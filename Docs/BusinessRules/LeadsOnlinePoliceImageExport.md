# LeadsOnline Police Image Export

How PawnPro uploads item and customer images to LeadsOnline (police reporting),
and the rules governing the **customer ID photo** send.

Screen: `TfrmExportPoliceInformation` ([ExportPoliceInformation.pas](../../ExportPoliceInformation.pas)),
**Send Images** tab. Transport is **FTP** (Indy `TIdFTP`); credentials come from
`DM.qryStore.LEADS_ONLINE_*`. (The SOAP `uLeadsOnlineUpload.pas` exists but is not wired in.)

## Two image kinds, two LeadsOnline filename shapes

Per the vendor spec (`PawnDocs/Uploading Images to LeadsOnline.pdf`), a 3-letter
picture-code = **class + camera + transaction-type**, and *transaction* images
omit the item-number component that *item* images carry:

| Kind | `IMAGE_TYPE_NO` | Keyed to | Filename | Builder |
|------|-----------------|----------|----------|---------|
| Item picture | 2 | `INV_ITEM_NO` | `IMG_AN{P\|B}_{store}_{date}_{ticket}_{item#:2}_{picID:3}.JPG` | `GetLeadsOnlineFileName` |
| Customer ID photo | 1 | `CUST_NO` | `IMG_IN{P\|B}_{store}_{date}_{ticket}_{picID:3}.JPG` (no item#) | `GetLeadsOnlineCustIdFileName` |

`P` = Pawn, `B` = Buy/Purchase (our `TRAN_TYPE='U'`). `picID` = `IMAGES_DATA_NO`.
The `{ticket}` is the customer-facing ticket number, matching the data file.

## Customer ID photo — the rules

The requirement: **always send the customer's ID photo, once per transaction, for
transactions that have item pictures being sent.**

1. **Only transactions in the send queue.** The customer-photo send is driven off
   the item-image loop (`qryImagesNotExp`, which lists item images with
   `UPLOAD_TIME IS NULL`). So it only ever fires for transactions that currently
   have **unsent item pictures**. A transaction whose item images are already all
   sent has left the queue and is never revisited — **already-sent work is not
   touched**.
2. **Once per transaction.** On each new `TRANSACTION_NO` in the loop,
   `SendCustomerIdImagesForTran` runs. Because a customer ID photo is a single
   `IMAGES_DATA` row shared across all of that customer's tickets, and a
   LeadsOnline transaction-image filename embeds **one** ticket number, the photo
   is uploaded once *per ticket* (each named with that ticket's number).
3. **No double-sends.** Each send is logged in **`EXPORT_IMAGE_SENT`**
   `(TRANSACTION_NO, IMAGES_DATA_NO)` (unique). The selector skips any photo
   already logged for that transaction, so re-running the send never re-uploads.
4. **"If exists" — dormant until photos are captured.** If a transaction's
   customer has no ID photo (`IMAGE_TYPE_NO=1`) row, the inner query returns
   nothing and the send is a silent no-op. At first rollout, when few customers
   have a captured ID photo, the process simply sends nothing until photos start
   to exist (captured via the same path as the Search-Customer "Customer
   Pictures" button, `ImageType_CustomerID`).
5. **No backfill.** A transaction whose item images were sent *before* this
   feature existed will not retroactively get its customer photo — it's no longer
   in the queue. Only transactions sending item pics **going forward** carry the
   photo the first time.

### Why a separate tracking table (not `IMAGES_DATA.UPLOAD_TIME`)

Item images dedupe on `IMAGES_DATA.UPLOAD_TIME` — fine, since one image row maps
to exactly one item in one transaction. A customer ID photo is shared across the
customer's transactions and must attach to **each** ticket separately, so a single
`UPLOAD_TIME` on the shared row can't represent "sent for ticket A but not B."
Hence per-`(transaction, image)` logging in `EXPORT_IMAGE_SENT`. The sent-history
grid (`qrySentImg`) UNIONs this table so uploaded customer photos are visible.

## Deployment

`EXPORT_IMAGE_SENT` is created by `Schema/Migrations/PawnPro_FB5_AddExportImageSent.sql`
(and is in the schema / full-deploy scripts). Already-deployed stores get it
automatically via the startup migration runner ([uDBMigrations.pas](../../uDBMigrations.pas)).
