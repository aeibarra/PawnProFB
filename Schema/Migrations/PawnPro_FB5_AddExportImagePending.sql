/* Remembers customer-ID uploads that qualified through the item-image queue but
   did not complete. Idempotent; mirrored by uDBMigrations version 2. */
SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATIONS
                  WHERE RDB$RELATION_NAME = 'EXPORT_IMAGE_PENDING')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE EXPORT_IMAGE_PENDING
       (
         TRANSACTION_NO INTEGER NOT NULL,
         QUEUED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
         CONSTRAINT PK_EXPORT_IMAGE_PENDING PRIMARY KEY (TRANSACTION_NO)
       )';
END^

SET TERM ; ^
COMMIT;
