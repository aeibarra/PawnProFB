from app.database import get_db

class Sale:
    @staticmethod
    def get_all(search=None):
        db = get_db()
        cur = db.cursor()
        if search:
            s = f'%{search.upper()}%'
            cur.execute(
                "SELECT S.SALE_ID, S.ITEM_ID, I.NAME as ITEM_NAME, S.CUSTOMER_ID, "
                "C.FIRST_NAME || ' ' || C.LAST_NAME as CUSTOMER_NAME, "
                "S.SALE_PRICE, S.SALE_DATE, S.NOTES, S.CREATED_AT "
                "FROM SALES S JOIN ITEMS I ON S.ITEM_ID = I.ITEM_ID "
                "LEFT JOIN CUSTOMERS C ON S.CUSTOMER_ID = C.CUSTOMER_ID "
                "WHERE UPPER(I.NAME) LIKE ? OR UPPER(C.FIRST_NAME) LIKE ? OR UPPER(C.LAST_NAME) LIKE ? "
                "ORDER BY S.SALE_DATE DESC",
                (s, s, s)
            )
        else:
            cur.execute(
                "SELECT S.SALE_ID, S.ITEM_ID, I.NAME as ITEM_NAME, S.CUSTOMER_ID, "
                "C.FIRST_NAME || ' ' || C.LAST_NAME as CUSTOMER_NAME, "
                "S.SALE_PRICE, S.SALE_DATE, S.NOTES, S.CREATED_AT "
                "FROM SALES S JOIN ITEMS I ON S.ITEM_ID = I.ITEM_ID "
                "LEFT JOIN CUSTOMERS C ON S.CUSTOMER_ID = C.CUSTOMER_ID "
                "ORDER BY S.SALE_DATE DESC"
            )
        columns = [desc[0].lower() for desc in cur.description]
        return [dict(zip(columns, row)) for row in cur.fetchall()]

    @staticmethod
    def create(item_id, customer_id, sale_price, sale_date, notes):
        db = get_db()
        cur = db.cursor()
        cur.execute(
            "INSERT INTO SALES (ITEM_ID, CUSTOMER_ID, SALE_PRICE, SALE_DATE, NOTES) "
            "VALUES (?, ?, ?, ?, ?) RETURNING SALE_ID",
            (item_id, customer_id or None, sale_price, sale_date, notes)
        )
        row = cur.fetchone()
        sale_id = row[0] if row else None
        cur.execute("UPDATE ITEMS SET STATUS = 'Sold' WHERE ITEM_ID = ?", (item_id,))
        db.commit()
        return sale_id

    @staticmethod
    def get_total_revenue():
        db = get_db()
        cur = db.cursor()
        cur.execute("SELECT COALESCE(SUM(SALE_PRICE), 0) FROM SALES")
        return float(cur.fetchone()[0])

    @staticmethod
    def get_monthly_revenue():
        db = get_db()
        cur = db.cursor()
        cur.execute(
            "SELECT COALESCE(SUM(SALE_PRICE), 0) FROM SALES "
            "WHERE EXTRACT(MONTH FROM SALE_DATE) = EXTRACT(MONTH FROM CURRENT_DATE) "
            "AND EXTRACT(YEAR FROM SALE_DATE) = EXTRACT(YEAR FROM CURRENT_DATE)"
        )
        return float(cur.fetchone()[0])
