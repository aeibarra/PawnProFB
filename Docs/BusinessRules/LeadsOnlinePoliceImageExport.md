# LeadsOnline Police Image Export

How PawnPro uploads item and customer images to LeadsOnline (police reporting),
including reliable customer-ID retry behavior.

Screen: `TfrmExportPoliceInformation`
([ExportPoliceInformation.pas](../../ExportPoliceInformation.pas)), **Send Images**
tab. Transport is FTP through Indy `TIdFTP`; credentials come from
`DM.qryStore.LEADS_ONLINE_FTP_ADDRESS` / `_USER_NAME` / `_PASSWORD`.

This FTP path is unaffected by the LeadsOnline SOAP channel. That channel is a
separate, opt-in export ([uLeadsOnlineClient.pas](../../uLeadsOnlineClient.pas)
over the generated proxy [LeadsOnlineWS.pas](../../LeadsOnlineWS.pas)) with its
own credentials in `STORE.LEADS_ONLINE_API_USER` / `_API_PASSWORD`, selected per
store by `STORE.LEADS_ONLINE_EXPORT_METHOD` (`'C'` = this CSV/FTP path, the
default; `'S'` = SOAP). Nothing dispatches on that column yet. The old
placeholder unit `uLeadsOnlineUpload.pas` was never wired in and has been
deleted.

## Image types and filenames

Per the vendor specification (`PawnDocs/Uploading Images to LeadsOnline.pdf`),
the three-letter picture code is class + camera + transaction type. Transaction
images omit the item-number component used by item images.

| Kind | `IMAGE_TYPE_NO` | Keyed to | Filename | Builder |
|---|---:|---|---|---|
| Item picture | 2 | `INV_ITEM_NO` | `IMG_AN{P\|B}_{store}_{date}_{ticket}_{item#:2}_{picID:3}.JPG` | `GetLeadsOnlineFileName` |
| Customer ID photo | 1 | `CUST_NO` | `IMG_IN{P\|B}_{store}_{date}_{ticket}_{picID:3}.JPG` | `GetLeadsOnlineCustIdFileName` |

`P` means Pawn. `B` means Buy/Purchase (`TRAN_TYPE='U'`). `picID` is
`IMAGES_DATA_NO`. `{ticket}` is the customer-facing ticket number used in the
export data file.

## Customer ID business rules

The requirement is to send the customer's ID photo once per qualifying
transaction. A transaction qualifies only when it enters the item-picture send
queue; transactions without item pictures are not included.

1. **Qualification comes from item pictures.** When the item-image loop reaches
   a transaction, PawnPro inserts or updates an `EXPORT_IMAGE_PENDING` row before
   attempting the customer ID upload. This persisted row proves that the
   transaction qualified and allows later retry even after all its item pictures
   have been marked sent.

2. **Item uploads are not blocked.** If the customer ID upload fails, PawnPro
   logs the error and continues sending item pictures. The pending row remains,
   so completing the item pictures cannot cause the failed customer ID to be
   forgotten.

3. **Pending IDs are retried automatically.** Every Send Images run processes
   `EXPORT_IMAGE_PENDING`, including runs where there are no unsent item images.
   A failed FTP transfer or image-export operation therefore remains eligible
   for a later attempt.

4. **Retries use the latest customer picture.** The customer may replace or
   recapture the ID photo after a failure. Each attempt selects only the newest
   `IMAGE_TYPE_NO=1` row for the customer, ordered by `CREATED DESC NULLS LAST`
   and then `IMAGES_DATA_NO DESC`. If the existing row was overwritten, its
   current image contents are exported.

5. **Success is transaction-based.** A successful upload is recorded in
   `EXPORT_IMAGE_SENT`. Once any customer ID image has succeeded for that
   transaction, its pending row is deleted and later changes to the customer's
   picture do not resend an already-completed historical ticket.

6. **No unintended historical backfill.** Retry processing reads only rows that
   the new item-image workflow placed in `EXPORT_IMAGE_PENDING`. It does not
   infer pending work from old export history, so installing this feature does
   not upload customer IDs for every historical transaction.

7. **No picture yet.** If the qualifying transaction's customer has no ID photo,
   the pending row remains. After an operator captures a customer ID photo, a
   later Send Images run can upload the new picture. As a consequence, a pending
   row for a customer who *never* captures an ID photo persists indefinitely:
   retry processing filters it out (rule 6 requires an existing `IMAGE_TYPE_NO=1`
   image), so it is never resent and never cleared. This is harmless — the row
   is inert — but `EXPORT_IMAGE_PENDING` should be read as "qualified, not yet
   delivered," not "actively retrying." There is deliberately no automatic
   cleanup, so the deferred-capture case in this rule keeps working.

## Tracking tables

Item images continue using `IMAGES_DATA.UPLOAD_TIME`, because an item-image row
belongs to one item in one transaction.

Customer ID images require transaction-level state because one customer image
can be shared by several tickets:

- `EXPORT_IMAGE_PENDING` contains one row per qualified transaction still
  needing a successful customer-ID upload. `QUEUED_AT` records when it was most
  recently queued.
- `EXPORT_IMAGE_SENT` records the successful `(TRANSACTION_NO,
  IMAGES_DATA_NO)` upload, timestamp, and LeadsOnline filename.

The sent-image history grid (`qrySentImg`) includes `EXPORT_IMAGE_SENT`, so
successfully uploaded customer pictures remain visible.

## Processing sequence

When the operator chooses Send Images:

1. Connect to LeadsOnline FTP.
2. Retry transactions already in `EXPORT_IMAGE_PENDING`.
3. Process the current unsent item-picture queue.
4. Before the first item image for each new transaction, persist its pending
   customer-ID state and attempt its latest ID photo.
5. On customer-ID success, write `EXPORT_IMAGE_SENT` and delete the pending row.
6. On customer-ID failure, leave the pending row for the next run.
7. Send and mark item pictures independently.

## Deployment

The automatic database migration version is 2.

- `EXPORT_IMAGE_SENT` was introduced by
  `Schema/Migrations/PawnPro_FB5_AddExportImageSent.sql` (version 1).
- `EXPORT_IMAGE_PENDING` is introduced by
  `Schema/Migrations/PawnPro_FB5_AddExportImagePending.sql` (version 2).

Both tables are included in `PawnPro_DB_Firebird50_Schema.sql` and
`PawnPro_FB5_NewStoreFullDeploy.sql`. Existing stores receive them through the
startup migration runner in [uDBMigrations.pas](../../uDBMigrations.pas).
