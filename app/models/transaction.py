from app.database import get_db
from datetime import date, timedelta

class Transaction:
    @staticmethod
    def get_all(status=None, search=None):
        db = get_db()
        cur = db.cursor()
        conditions = []
        params = []
        if status:
            conditions.append("PT.STATUS = ?")
            params.append(status)
        if search:
            s = f'%{search.upper()}%'
            conditions.append("(UPPER(C.FIRST_NAME) LIKE ? OR UPPER(C.LAST_NAME) LIKE ?)")
            params.extend([s, s])
        where = "WHERE " + " AND ".join(conditions) if conditions else ""
        cur.execute(
            f"SELECT PT.TRANSACTION_ID, PT.CUSTOMER_ID, C.FIRST_NAME || ' ' || C.LAST_NAME as CUSTOMER_NAME, "
            f"PT.LOAN_AMOUNT, PT.INTEREST_RATE, PT.START_DATE, PT.DUE_DATE, PT.STATUS, "
            f"PT.TOTAL_AMOUNT_DUE, PT.AMOUNT_PAID, PT.NOTES, PT.CREATED_AT "
            f"FROM PAWN_TRANSACTIONS PT JOIN CUSTOMERS C ON PT.CUSTOMER_ID = C.CUSTOMER_ID {where} "
            f"ORDER BY PT.CREATED_AT DESC",
            params
        )
        columns = [desc[0].lower() for desc in cur.description]
        return [dict(zip(columns, row)) for row in cur.fetchall()]

    @staticmethod
    def get_by_id(transaction_id):
        db = get_db()
        cur = db.cursor()
        cur.execute(
            "SELECT PT.TRANSACTION_ID, PT.CUSTOMER_ID, C.FIRST_NAME || ' ' || C.LAST_NAME as CUSTOMER_NAME, "
            "PT.LOAN_AMOUNT, PT.INTEREST_RATE, PT.START_DATE, PT.DUE_DATE, PT.STATUS, "
            "PT.TOTAL_AMOUNT_DUE, PT.AMOUNT_PAID, PT.NOTES, PT.CREATED_AT "
            "FROM PAWN_TRANSACTIONS PT JOIN CUSTOMERS C ON PT.CUSTOMER_ID = C.CUSTOMER_ID "
            "WHERE PT.TRANSACTION_ID = ?",
            (transaction_id,)
        )
        columns = [desc[0].lower() for desc in cur.description]
        row = cur.fetchone()
        return dict(zip(columns, row)) if row else None

    @staticmethod
    def get_items(transaction_id):
        db = get_db()
        cur = db.cursor()
        cur.execute(
            "SELECT I.ITEM_ID, I.NAME, I.BRAND, I.MODEL, I.CONDITION, I.STATUS, I.APPRAISED_VALUE, C.NAME as CATEGORY_NAME "
            "FROM TRANSACTION_ITEMS TI "
            "JOIN ITEMS I ON TI.ITEM_ID = I.ITEM_ID "
            "LEFT JOIN CATEGORIES C ON I.CATEGORY_ID = C.CATEGORY_ID "
            "WHERE TI.TRANSACTION_ID = ?",
            (transaction_id,)
        )
        columns = [desc[0].lower() for desc in cur.description]
        return [dict(zip(columns, row)) for row in cur.fetchall()]

    @staticmethod
    def create(customer_id, loan_amount, interest_rate, due_date, item_ids, notes):
        db = get_db()
        cur = db.cursor()
        total = float(loan_amount) * (1 + float(interest_rate) / 100)
        cur.execute(
            "INSERT INTO PAWN_TRANSACTIONS (CUSTOMER_ID, LOAN_AMOUNT, INTEREST_RATE, DUE_DATE, TOTAL_AMOUNT_DUE, NOTES) "
            "VALUES (?, ?, ?, ?, ?, ?) RETURNING TRANSACTION_ID",
            (customer_id, loan_amount, interest_rate, due_date, total, notes)
        )
        row = cur.fetchone()
        transaction_id = row[0] if row else None
        if transaction_id and item_ids:
            for item_id in item_ids:
                cur.execute(
                    "INSERT INTO TRANSACTION_ITEMS (TRANSACTION_ID, ITEM_ID) VALUES (?, ?)",
                    (transaction_id, item_id)
                )
                cur.execute("UPDATE ITEMS SET STATUS = 'Pawned' WHERE ITEM_ID = ?", (item_id,))
        db.commit()
        return transaction_id

    @staticmethod
    def update_status(transaction_id, status):
        db = get_db()
        cur = db.cursor()
        cur.execute("UPDATE PAWN_TRANSACTIONS SET STATUS=? WHERE TRANSACTION_ID=?", (status, transaction_id))
        if status in ('Redeemed', 'Forfeited'):
            new_item_status = 'Available' if status == 'Redeemed' else 'For Sale'
            cur.execute(
                "UPDATE ITEMS SET STATUS = ? WHERE ITEM_ID IN "
                "(SELECT ITEM_ID FROM TRANSACTION_ITEMS WHERE TRANSACTION_ID = ?)",
                (new_item_status, transaction_id)
            )
        db.commit()

    @staticmethod
    def get_overdue():
        db = get_db()
        cur = db.cursor()
        cur.execute(
            "SELECT COUNT(*) FROM PAWN_TRANSACTIONS WHERE STATUS = 'Active' AND DUE_DATE < CURRENT_DATE"
        )
        return cur.fetchone()[0]

    @staticmethod
    def get_counts_by_status():
        db = get_db()
        cur = db.cursor()
        cur.execute("SELECT STATUS, COUNT(*) FROM PAWN_TRANSACTIONS GROUP BY STATUS")
        return dict(cur.fetchall())
