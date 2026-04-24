/*******************************************************************************
 * PawnPro - Firebird 5 trigger, function and stored procedures
 *
 * Run after PawnPro_FB5_AddMissingObjects.sql (this depends on
 * INVENTORY_ITEM_STATUS_LOG existing).
 *
 * Contents:
 *   1. Trigger TRG_INV_ITEMS_STATUS_LOG  (ports trg_InvItems_StatusLog)
 *   2. Function FN_TRAN_WITH_LATE_PAYMENT (ports fn_TranWithLatePayment)
 *   3. Procedure SP_CONNECTED             (ports sp_Connected)
 *   4. Procedure SPI_GOLD_PRICE           (ports spi_GoldPrice)
 *   5. Procedure SPU_CALC_UNIT_COST_FROM_WEIGHT (ports spu_CalcUnitCostFromWeight)
 *   6. Procedure SP_CREATE_EXPORT_LOG     (ports CreateExportLog)
 *   7. Procedure REP_CUSTOMER_WITH_LATE_PAYMENTS (ports Rep_CustomerWithLatePayments)
 *
 * Ordering: the function is created before REP_CUSTOMER_WITH_LATE_PAYMENTS
 * because the latter calls the former.
 ******************************************************************************/

SET TERM ^^ ;


/* ---------------------------------------------------------------------------
 * 1. Trigger - logs status / date changes on INVENTORY_ITEMS
 * ------------------------------------------------------------------------ */

CREATE OR ALTER TRIGGER TRG_INV_ITEMS_STATUS_LOG FOR INVENTORY_ITEMS
AFTER UPDATE
AS
BEGIN
  IF (OLD.INV_ITEM_STATUS IS DISTINCT FROM NEW.INV_ITEM_STATUS
      OR OLD.PAWNED_DATE    IS DISTINCT FROM NEW.PAWNED_DATE
      OR OLD.PURCHASE_DATE  IS DISTINCT FROM NEW.PURCHASE_DATE
      OR OLD.REDEEMED_DATE  IS DISTINCT FROM NEW.REDEEMED_DATE
      OR OLD.DEFAULTED_DATE IS DISTINCT FROM NEW.DEFAULTED_DATE
      OR OLD.MELTED_DATE    IS DISTINCT FROM NEW.MELTED_DATE
      OR OLD.FORSALE_DATE   IS DISTINCT FROM NEW.FORSALE_DATE
      OR OLD.SOLD_DATE      IS DISTINCT FROM NEW.SOLD_DATE
      OR OLD.LAYAWAY_DATE   IS DISTINCT FROM NEW.LAYAWAY_DATE) THEN
  BEGIN
    INSERT INTO INVENTORY_ITEM_STATUS_LOG (
      INV_ITEM_NO,
      OLD_STATUS,         NEW_STATUS,
      OLD_PAWNED_DATE,    NEW_PAWNED_DATE,
      OLD_PURCHASE_DATE,  NEW_PURCHASE_DATE,
      OLD_REDEEMED_DATE,  NEW_REDEEMED_DATE,
      OLD_DEFAULTED_DATE, NEW_DEFAULTED_DATE,
      OLD_MELTED_DATE,    NEW_MELTED_DATE,
      OLD_FORSALE_DATE,   NEW_FORSALE_DATE,
      OLD_SOLD_DATE,      NEW_SOLD_DATE,
      OLD_LAYAWAY_DATE,   NEW_LAYAWAY_DATE,
      CHANGED_BY
    ) VALUES (
      NEW.INV_ITEM_NO,
      OLD.INV_ITEM_STATUS, NEW.INV_ITEM_STATUS,
      OLD.PAWNED_DATE,     NEW.PAWNED_DATE,
      OLD.PURCHASE_DATE,   NEW.PURCHASE_DATE,
      OLD.REDEEMED_DATE,   NEW.REDEEMED_DATE,
      OLD.DEFAULTED_DATE,  NEW.DEFAULTED_DATE,
      OLD.MELTED_DATE,     NEW.MELTED_DATE,
      OLD.FORSALE_DATE,    NEW.FORSALE_DATE,
      OLD.SOLD_DATE,       NEW.SOLD_DATE,
      OLD.LAYAWAY_DATE,    NEW.LAYAWAY_DATE,
      CURRENT_USER
    );
  END
END ^^


/* ---------------------------------------------------------------------------
 * 2. Function FN_TRAN_WITH_LATE_PAYMENT
 *    Returns 1 if the given transaction's last activity (last payment, or
 *    pawn date if no payments) is more than MONS months away from today.
 * ------------------------------------------------------------------------ */

CREATE OR ALTER FUNCTION FN_TRAN_WITH_LATE_PAYMENT (
  TRANSACTION_NO INTEGER,
  MONS INTEGER = 1)
 RETURNS SMALLINT
AS
  DECLARE VARIABLE PAWN_DATE     DATE;
  DECLARE VARIABLE LAST_PAY_DAY  DATE;
  DECLARE VARIABLE CMP_DATE      DATE;
BEGIN
  SELECT TRAN_DATE       FROM TRANSACTIONS WHERE TRANSACTION_NO = :TRANSACTION_NO INTO :PAWN_DATE;
  SELECT MAX(PAY_DATE)   FROM PAYMENTS     WHERE TRANSACTION_NO = :TRANSACTION_NO INTO :LAST_PAY_DAY;

  CMP_DATE = COALESCE(:LAST_PAY_DAY, :PAWN_DATE);
  IF (:CMP_DATE IS NULL) THEN
    RETURN 0;

  IF (ABS(DATEDIFF(MONTH FROM :CMP_DATE TO CURRENT_DATE)) > :MONS) THEN
    RETURN 1;
  ELSE
    RETURN 0;
END ^^


/* ---------------------------------------------------------------------------
 * 3. Procedure SP_CONNECTED
 *    Marks a workstation connected ('Y') or disconnected (any other value)
 *    and stamps CONN_START / CONN_THRU.
 * ------------------------------------------------------------------------ */

CREATE OR ALTER PROCEDURE SP_CONNECTED (
  STATION_NO INTEGER,
  CONN CHAR(1))
AS
BEGIN
  IF (UPPER(:CONN) = 'Y') THEN
    UPDATE STATIONS
      SET STATION_CONNECTED = UPPER(:CONN),
          CONN_START        = CURRENT_TIMESTAMP
      WHERE STATION_NO = :STATION_NO;
  ELSE
    UPDATE STATIONS
      SET STATION_CONNECTED = UPPER(:CONN),
          CONN_THRU         = CURRENT_TIMESTAMP
      WHERE STATION_NO = :STATION_NO;
END ^^


/* ---------------------------------------------------------------------------
 * 4. Procedure SPI_GOLD_PRICE
 *    Inserts a new gold-price row only when the price differs from the
 *    most recent one. Returns the previous price in LAST_G_PRICE so the
 *    caller can compare and colour the UI.
 * ------------------------------------------------------------------------ */

CREATE OR ALTER PROCEDURE SPI_GOLD_PRICE (
  PRICE_PER_OUNCE DECIMAL(10,2),
  CURRENCY VARCHAR(3))
 RETURNS (
  LAST_G_PRICE DECIMAL(10,2))
AS
BEGIN
  LAST_G_PRICE = 0;

  SELECT FIRST 1 PRICE_PER_OUNCE
    FROM GOLD_PRICE_HISTORY
    ORDER BY PRICE_ID DESC
    INTO :LAST_G_PRICE;

  LAST_G_PRICE = COALESCE(:LAST_G_PRICE, 0);

  IF (:LAST_G_PRICE <> :PRICE_PER_OUNCE) THEN
    INSERT INTO GOLD_PRICE_HISTORY (PRICE_PER_OUNCE, CURRENCY, FETCHDATETIME, SOURCE)
      VALUES (:PRICE_PER_OUNCE, :CURRENCY, CURRENT_TIMESTAMP, 'CryptoCompare');

  SUSPEND;
END ^^


/* ---------------------------------------------------------------------------
 * 5. Procedure SPU_CALC_UNIT_COST_FROM_WEIGHT
 *    For all InventoryItems under TRANSACTION_NO, distributes the transaction's
 *    pawn amount across items proportionally to WEIGHT and stores in UNIT_COST.
 *    Raises a divide-by-zero error if total weight is NULL or 0 (same as ASA).
 * ------------------------------------------------------------------------ */

CREATE OR ALTER PROCEDURE SPU_CALC_UNIT_COST_FROM_WEIGHT (
  TRANSACTION_NO INTEGER)
AS
  DECLARE VARIABLE TOTAL_WEIGHT      DOUBLE PRECISION;
  DECLARE VARIABLE TOTAL_AMOUNT      DOUBLE PRECISION;
  DECLARE VARIABLE DOLLAR_PER_WEIGHT DOUBLE PRECISION;
BEGIN
  SELECT SUM(WEIGHT)       FROM INVENTORY_ITEMS WHERE TRANSACTION_NO = :TRANSACTION_NO INTO :TOTAL_WEIGHT;
  SELECT TRAN_PAWN_AMOUNT  FROM TRANSACTIONS    WHERE TRANSACTION_NO = :TRANSACTION_NO INTO :TOTAL_AMOUNT;

  DOLLAR_PER_WEIGHT = :TOTAL_AMOUNT / :TOTAL_WEIGHT;

  UPDATE INVENTORY_ITEMS
    SET UNIT_COST = :DOLLAR_PER_WEIGHT * WEIGHT
    WHERE TRANSACTION_NO = :TRANSACTION_NO;
END ^^


/* ---------------------------------------------------------------------------
 * 6. Procedure SP_CREATE_EXPORT_LOG
 *    Creates a new EXPORT_FILE_LOG row and returns the generated id.
 *    Replaces ASA's @@Identity pattern with Firebird's RETURNING.
 * ------------------------------------------------------------------------ */

CREATE OR ALTER PROCEDURE SP_CREATE_EXPORT_LOG (
  FILE_NAME VARCHAR(50))
 RETURNS (
  EXPORT_LOG_ID INTEGER)
AS
BEGIN
  INSERT INTO EXPORT_FILE_LOG (EXPORT_DATE, FILE_NAME)
    VALUES (CURRENT_TIMESTAMP, :FILE_NAME)
    RETURNING EXPORT_LOG_ID INTO :EXPORT_LOG_ID;
  SUSPEND;
END ^^


/* ---------------------------------------------------------------------------
 * 7. Procedure REP_CUSTOMER_WITH_LATE_PAYMENTS
 *    Lists up to 1000 active pawn transactions whose last activity is more
 *    than MONS months old. Ordered by customer name. LATE_PAYMENT is always 1
 *    in the result set (the filter guarantees it).
 * ------------------------------------------------------------------------ */

CREATE OR ALTER PROCEDURE REP_CUSTOMER_WITH_LATE_PAYMENTS (
  MONS INTEGER = 1)
 RETURNS (
  TRANSACTION_NO INTEGER,
  TRAN_TICKET_NO VARCHAR(30),
  TRAN_DATE TIMESTAMP,
  LATE_PAYMENT SMALLINT,
  CUST_NO INTEGER,
  CUST_LAST VARCHAR(35),
  CUST_FIRST VARCHAR(35),
  CUST_MID CHAR(1),
  CUST_PH_CELL VARCHAR(14),
  CUST_PH_HOME VARCHAR(14),
  CUST_PH_BUSINESS VARCHAR(14),
  TRAN_PAWN_AMOUNT DOUBLE PRECISION)
AS
BEGIN
  FOR
    SELECT FIRST 1000
      T2.TRANSACTION_NO,
      T2.TRAN_TICKET_NO,
      CAST(T2.TRAN_DATE AS TIMESTAMP),
      1,
      T1.CUST_NO,
      T1.CUST_LAST,
      T1.CUST_FIRST,
      T1.CUST_MID,
      T1.CUST_PH_CELL,
      T1.CUST_PH_HOME,
      T1.CUST_PH_BUSINESS,
      T2.TRAN_PAWN_AMOUNT
    FROM CUSTOMER T1
      JOIN TRANSACTIONS T2 ON T1.CUST_NO = T2.CUST_NO
    WHERE T2.TRAN_TYPE   = 'P'
      AND T2.TRAN_STATUS = 'A'
      AND FN_TRAN_WITH_LATE_PAYMENT(T2.TRANSACTION_NO, :MONS) = 1
    ORDER BY T1.CUST_FIRST ASC, T1.CUST_LAST ASC, T1.CUST_NO ASC
    INTO
      :TRANSACTION_NO,
      :TRAN_TICKET_NO,
      :TRAN_DATE,
      :LATE_PAYMENT,
      :CUST_NO,
      :CUST_LAST,
      :CUST_FIRST,
      :CUST_MID,
      :CUST_PH_CELL,
      :CUST_PH_HOME,
      :CUST_PH_BUSINESS,
      :TRAN_PAWN_AMOUNT
  DO
    SUSPEND;
END ^^


SET TERM ; ^^

COMMIT;
