from app.database import get_db

class Customer:
    @staticmethod
    def get_all(search=None):
        db = get_db()
        cur = db.cursor()
        if search:
            search_term = f'%{search.upper()}%'
            cur.execute(
                "SELECT CUSTOMER_ID, FIRST_NAME, LAST_NAME, PHONE, EMAIL, ADDRESS, ID_TYPE, ID_NUMBER, CREATED_AT, NOTES "
                "FROM CUSTOMERS WHERE UPPER(FIRST_NAME) LIKE ? OR UPPER(LAST_NAME) LIKE ? OR UPPER(PHONE) LIKE ? OR UPPER(EMAIL) LIKE ? "
                "ORDER BY LAST_NAME, FIRST_NAME",
                (search_term, search_term, search_term, search_term)
            )
        else:
            cur.execute(
                "SELECT CUSTOMER_ID, FIRST_NAME, LAST_NAME, PHONE, EMAIL, ADDRESS, ID_TYPE, ID_NUMBER, CREATED_AT, NOTES "
                "FROM CUSTOMERS ORDER BY LAST_NAME, FIRST_NAME"
            )
        columns = [desc[0].lower() for desc in cur.description]
        return [dict(zip(columns, row)) for row in cur.fetchall()]

    @staticmethod
    def get_by_id(customer_id):
        db = get_db()
        cur = db.cursor()
        cur.execute(
            "SELECT CUSTOMER_ID, FIRST_NAME, LAST_NAME, PHONE, EMAIL, ADDRESS, ID_TYPE, ID_NUMBER, CREATED_AT, NOTES "
            "FROM CUSTOMERS WHERE CUSTOMER_ID = ?",
            (customer_id,)
        )
        columns = [desc[0].lower() for desc in cur.description]
        row = cur.fetchone()
        return dict(zip(columns, row)) if row else None

    @staticmethod
    def create(first_name, last_name, phone, email, address, id_type, id_number, notes):
        db = get_db()
        cur = db.cursor()
        cur.execute(
            "INSERT INTO CUSTOMERS (FIRST_NAME, LAST_NAME, PHONE, EMAIL, ADDRESS, ID_TYPE, ID_NUMBER, NOTES) "
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING CUSTOMER_ID",
            (first_name, last_name, phone, email, address, id_type, id_number, notes)
        )
        row = cur.fetchone()
        db.commit()
        return row[0] if row else None

    @staticmethod
    def update(customer_id, first_name, last_name, phone, email, address, id_type, id_number, notes):
        db = get_db()
        cur = db.cursor()
        cur.execute(
            "UPDATE CUSTOMERS SET FIRST_NAME=?, LAST_NAME=?, PHONE=?, EMAIL=?, ADDRESS=?, ID_TYPE=?, ID_NUMBER=?, NOTES=? "
            "WHERE CUSTOMER_ID=?",
            (first_name, last_name, phone, email, address, id_type, id_number, notes, customer_id)
        )
        db.commit()

    @staticmethod
    def delete(customer_id):
        db = get_db()
        cur = db.cursor()
        cur.execute("DELETE FROM CUSTOMERS WHERE CUSTOMER_ID = ?", (customer_id,))
        db.commit()

    @staticmethod
    def get_transaction_count(customer_id):
        db = get_db()
        cur = db.cursor()
        cur.execute("SELECT COUNT(*) FROM PAWN_TRANSACTIONS WHERE CUSTOMER_ID = ?", (customer_id,))
        return cur.fetchone()[0]
