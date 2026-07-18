/*******************************************************************************
 * PawnPro - Firebird 5: drop the retired late-payment report objects
 * ------------------------------------------------------------------
 * Report01 (the late-payment report) now computes lateness in Pascal via
 * DM.GetInterestAndNextPaymentInfo -- the same engine the payment screen uses.
 * The old SQL objects are no longer called by anything:
 *
 *   PROCEDURE REP_CUSTOMER_WITH_LATE_PAYMENTS  (flagged late by "months since
 *                                               last PAY_DATE" -- a proxy that
 *                                               ignored the money and drifted)
 *   FUNCTION  FN_TRAN_WITH_LATE_PAYMENT         (its per-transaction helper)
 *
 * Idempotent: safe to run more than once. Drop the PROCEDURE first -- it depends
 * on the FUNCTION, and Firebird refuses to drop a function still in use.
 *
 * Mirrored by Step3_DropLatePaymentReportProc in uDBMigrations.pas (v3), which
 * applies this automatically at startup for already-deployed stores.
 ******************************************************************************/

SET TERM ^^ ;

EXECUTE BLOCK AS
BEGIN
  IF (EXISTS(SELECT 1 FROM RDB$PROCEDURES
             WHERE RDB$PROCEDURE_NAME = 'REP_CUSTOMER_WITH_LATE_PAYMENTS')) THEN
    EXECUTE STATEMENT 'DROP PROCEDURE REP_CUSTOMER_WITH_LATE_PAYMENTS';

  IF (EXISTS(SELECT 1 FROM RDB$FUNCTIONS
             WHERE RDB$FUNCTION_NAME = 'FN_TRAN_WITH_LATE_PAYMENT')) THEN
    EXECUTE STATEMENT 'DROP FUNCTION FN_TRAN_WITH_LATE_PAYMENT';
END ^^

SET TERM ; ^^

COMMIT;
