/*******************************************************************************
 * Report01 (late-payment) TEST SEED
 * ---------------------------------
 * Loads 11 controlled pawn scenarios into a BLANK/seed database so the realigned
 * late-payment report can be verified against known expected results.
 *
 * Model recap (what the report uses):
 *   monthly interest = TRAN_PAWN_AMOUNT * TRAN_INTEREST/100
 *   late  := InterestOwedToday > 0   (past-due interest beyond the current month)
 *   MonthsLate := Ceil(InterestOwedToday / current monthly interest)
 *
 * All amounts use principal 1000 @ 10%/month => $100/month interest (except the
 * zero-rate and principal-reduction cases). Pawn dates are expressed in DAYS from
 * CURRENT_DATE, chosen to land in the MIDDLE of each month-band so the engine's
 * day-based MonthsBetween is robust to the actual run date:
 *     -10d => 0 mo,  -45d => 1 mo,  -75d => 2 mo,  -100d => 3 mo,  -130d => 4 mo
 *
 * IDs start at 9001 so they never collide with app-created rows. This is a
 * THROWAWAY test DB; re-run the cleanup section at the bottom to remove them.
 *
 * Run:
 *   isql -i Schema\Test\Report01_LatePayment_TestSeed.sql -user sysdba -password <pw> 127.0.0.1/3050:C:\DB\PAWNDATA.FDB
 ******************************************************************************/

/* ---- T01  New pawn, no payments .................... NOT late (0 mo) -------- */
INSERT INTO CUSTOMER (CUST_NO, CUST_FIRST, CUST_MID, CUST_LAST, CUST_PH_CELL)
  VALUES (9001, 'T01', 'X', 'NewNoPay_NotLate', '305-000-9001');
INSERT INTO TRANSACTIONS (TRANSACTION_NO, CUST_NO, TRAN_DATE, TRAN_TICKET_NO,
                          TRAN_TYPE, TRAN_STATUS, TRAN_PAWN_AMOUNT, TRAN_INTEREST, TRAN_CLOSE_REASON)
  VALUES (9001, 9001, DATEADD(-10 DAY TO CURRENT_DATE), 'TEST-01', 'P', 'A', 1000, 10, 0);

/* ---- T02  1 month old, no payments ................. LATE, 1 mo, owed $100 -- */
INSERT INTO CUSTOMER (CUST_NO, CUST_FIRST, CUST_MID, CUST_LAST, CUST_PH_CELL)
  VALUES (9002, 'T02', 'X', 'OneMonth_Late', '305-000-9002');
INSERT INTO TRANSACTIONS (TRANSACTION_NO, CUST_NO, TRAN_DATE, TRAN_TICKET_NO,
                          TRAN_TYPE, TRAN_STATUS, TRAN_PAWN_AMOUNT, TRAN_INTEREST, TRAN_CLOSE_REASON)
  VALUES (9002, 9002, DATEADD(-45 DAY TO CURRENT_DATE), 'TEST-02', 'P', 'A', 1000, 10, 0);

/* ---- T03  3 months old, no payments ................ LATE, 3 mo, owed $300 -- */
INSERT INTO CUSTOMER (CUST_NO, CUST_FIRST, CUST_MID, CUST_LAST, CUST_PH_CELL)
  VALUES (9003, 'T03', 'X', 'ThreeMonth_Late', '305-000-9003');
INSERT INTO TRANSACTIONS (TRANSACTION_NO, CUST_NO, TRAN_DATE, TRAN_TICKET_NO,
                          TRAN_TYPE, TRAN_STATUS, TRAN_PAWN_AMOUNT, TRAN_INTEREST, TRAN_CLOSE_REASON)
  VALUES (9003, 9003, DATEADD(-100 DAY TO CURRENT_DATE), 'TEST-03', 'P', 'A', 1000, 10, 0);

/* ---- T04  3 months old, interest fully caught up ... NOT late -------------- */
INSERT INTO CUSTOMER (CUST_NO, CUST_FIRST, CUST_MID, CUST_LAST, CUST_PH_CELL)
  VALUES (9004, 'T04', 'X', 'CaughtUp_NotLate', '305-000-9004');
INSERT INTO TRANSACTIONS (TRANSACTION_NO, CUST_NO, TRAN_DATE, TRAN_TICKET_NO,
                          TRAN_TYPE, TRAN_STATUS, TRAN_PAWN_AMOUNT, TRAN_INTEREST, TRAN_CLOSE_REASON)
  VALUES (9004, 9004, DATEADD(-100 DAY TO CURRENT_DATE), 'TEST-04', 'P', 'A', 1000, 10, 0);
/* paid the 3 past-due months of interest recently; principal unchanged */
INSERT INTO PAYMENTS (PAYMENT_NO, TRANSACTION_NO, PAY_DATE, PAY_AMOUNT, PAY_INTEREST, PAY_PRINCIPAL, PRINC_BALANCE)
  VALUES (9004, 9004, DATEADD(-5 DAY TO CURRENT_DATE), 300, 300, 0, 1000);

/* ---- T05  Prepaid LONG AGO, still covered .......... NOT late  (DISCRIMINATOR)
   Last payment is ~3 months old, so the OLD report would flag this ~3 mo late.
   The NEW report must EXCLUDE it: the customer prepaid enough interest to remain
   current today. This is the false-positive the realignment fixes. ----------- */
INSERT INTO CUSTOMER (CUST_NO, CUST_FIRST, CUST_MID, CUST_LAST, CUST_PH_CELL)
  VALUES (9005, 'T05', 'X', 'PrepaidOld_NotLate', '305-000-9005');
INSERT INTO TRANSACTIONS (TRANSACTION_NO, CUST_NO, TRAN_DATE, TRAN_TICKET_NO,
                          TRAN_TYPE, TRAN_STATUS, TRAN_PAWN_AMOUNT, TRAN_INTEREST, TRAN_CLOSE_REASON)
  VALUES (9005, 9005, DATEADD(-130 DAY TO CURRENT_DATE), 'TEST-05', 'P', 'A', 1000, 10, 0);
/* one big interest prepayment 95 days ago that covers all accrued months + current */
INSERT INTO PAYMENTS (PAYMENT_NO, TRANSACTION_NO, PAY_DATE, PAY_AMOUNT, PAY_INTEREST, PAY_PRINCIPAL, PRINC_BALANCE)
  VALUES (9005, 9005, DATEADD(-95 DAY TO CURRENT_DATE), 500, 500, 0, 1000);

/* ---- T06  Token RECENT payment, still behind ....... LATE, ~3 mo, owed $250
   (DISCRIMINATOR) Last payment is 2 days ago, so the OLD report would treat this
   as current and MISS it. The NEW report must INCLUDE it -- a tiny payment did
   not clear the past-due interest. This is the false-negative the fix cures. -- */
INSERT INTO CUSTOMER (CUST_NO, CUST_FIRST, CUST_MID, CUST_LAST, CUST_PH_CELL)
  VALUES (9006, 'T06', 'X', 'TokenRecent_Late', '305-000-9006');
INSERT INTO TRANSACTIONS (TRANSACTION_NO, CUST_NO, TRAN_DATE, TRAN_TICKET_NO,
                          TRAN_TYPE, TRAN_STATUS, TRAN_PAWN_AMOUNT, TRAN_INTEREST, TRAN_CLOSE_REASON)
  VALUES (9006, 9006, DATEADD(-100 DAY TO CURRENT_DATE), 'TEST-06', 'P', 'A', 1000, 10, 0);
INSERT INTO PAYMENTS (PAYMENT_NO, TRANSACTION_NO, PAY_DATE, PAY_AMOUNT, PAY_INTEREST, PAY_PRINCIPAL, PRINC_BALANCE)
  VALUES (9006, 9006, DATEADD(-2 DAY TO CURRENT_DATE), 50, 50, 0, 1000);

/* ---- T07  Principal reduced mid-loan .............. LATE, 2 mo, owed $100
   After ~1 month the customer paid principal down 1000 -> 500, so the current
   monthly charge is $50. MonthsLate must use the CURRENT principal: Ceil(100/50)
   = 2. If it wrongly used the original $100/mo it would show 1. ------------- */
INSERT INTO CUSTOMER (CUST_NO, CUST_FIRST, CUST_MID, CUST_LAST, CUST_PH_CELL)
  VALUES (9007, 'T07', 'X', 'PrincipalCut_Late', '305-000-9007');
INSERT INTO TRANSACTIONS (TRANSACTION_NO, CUST_NO, TRAN_DATE, TRAN_TICKET_NO,
                          TRAN_TYPE, TRAN_STATUS, TRAN_PAWN_AMOUNT, TRAN_INTEREST, TRAN_CLOSE_REASON)
  VALUES (9007, 9007, DATEADD(-75 DAY TO CURRENT_DATE), 'TEST-07', 'P', 'A', 1000, 10, 0);
/* pays first month's $100 interest + $500 principal, 40 days ago */
INSERT INTO PAYMENTS (PAYMENT_NO, TRANSACTION_NO, PAY_DATE, PAY_AMOUNT, PAY_INTEREST, PAY_PRINCIPAL, PRINC_BALANCE)
  VALUES (9007, 9007, DATEADD(-40 DAY TO CURRENT_DATE), 600, 100, 500, 500);

/* ---- T08  Zero-interest pawn ...................... NOT late (guard) -------- */
INSERT INTO CUSTOMER (CUST_NO, CUST_FIRST, CUST_MID, CUST_LAST, CUST_PH_CELL)
  VALUES (9008, 'T08', 'X', 'ZeroRate_NotLate', '305-000-9008');
INSERT INTO TRANSACTIONS (TRANSACTION_NO, CUST_NO, TRAN_DATE, TRAN_TICKET_NO,
                          TRAN_TYPE, TRAN_STATUS, TRAN_PAWN_AMOUNT, TRAN_INTEREST, TRAN_CLOSE_REASON)
  VALUES (9008, 9008, DATEADD(-100 DAY TO CURRENT_DATE), 'TEST-08', 'P', 'A', 1000, 0, 0);

/* ---- T09  CLOSED pawn that would be late .......... EXCLUDED (status <> A) -- */
INSERT INTO CUSTOMER (CUST_NO, CUST_FIRST, CUST_MID, CUST_LAST, CUST_PH_CELL)
  VALUES (9009, 'T09', 'X', 'Closed_Excluded', '305-000-9009');
INSERT INTO TRANSACTIONS (TRANSACTION_NO, CUST_NO, TRAN_DATE, TRAN_TICKET_NO,
                          TRAN_TYPE, TRAN_STATUS, TRAN_PAWN_AMOUNT, TRAN_INTEREST, TRAN_CLOSE_REASON)
  VALUES (9009, 9009, DATEADD(-100 DAY TO CURRENT_DATE), 'TEST-09', 'P', 'I', 1000, 10, 2);

/* ---- T10  LAYAWAY that would be late .............. EXCLUDED (type <> P) ---- */
INSERT INTO CUSTOMER (CUST_NO, CUST_FIRST, CUST_MID, CUST_LAST, CUST_PH_CELL)
  VALUES (9010, 'T10', 'X', 'Layaway_Excluded', '305-000-9010');
INSERT INTO TRANSACTIONS (TRANSACTION_NO, CUST_NO, TRAN_DATE, TRAN_TICKET_NO,
                          TRAN_TYPE, TRAN_STATUS, TRAN_PAWN_AMOUNT, TRAN_INTEREST, TRAN_CLOSE_REASON)
  VALUES (9010, 9010, DATEADD(-100 DAY TO CURRENT_DATE), 'TEST-10', 'L', 'A', 1000, 10, 0);

/* ---- T11  Exactly 2 months behind ................. LATE, 2 mo (threshold) -- */
INSERT INTO CUSTOMER (CUST_NO, CUST_FIRST, CUST_MID, CUST_LAST, CUST_PH_CELL)
  VALUES (9011, 'T11', 'X', 'TwoMonth_Boundary', '305-000-9011');
INSERT INTO TRANSACTIONS (TRANSACTION_NO, CUST_NO, TRAN_DATE, TRAN_TICKET_NO,
                          TRAN_TYPE, TRAN_STATUS, TRAN_PAWN_AMOUNT, TRAN_INTEREST, TRAN_CLOSE_REASON)
  VALUES (9011, 9011, DATEADD(-75 DAY TO CURRENT_DATE), 'TEST-11', 'P', 'A', 1000, 10, 0);

COMMIT;

/*******************************************************************************
 * CLEANUP (run to remove all test rows):
 *
 *   DELETE FROM PAYMENTS     WHERE TRANSACTION_NO >= 9001 AND TRANSACTION_NO <= 9011;
 *   DELETE FROM TRANSACTIONS WHERE TRANSACTION_NO >= 9001 AND TRANSACTION_NO <= 9011;
 *   DELETE FROM CUSTOMER     WHERE CUST_NO        >= 9001 AND CUST_NO        <= 9011;
 *   COMMIT;
 ******************************************************************************/
