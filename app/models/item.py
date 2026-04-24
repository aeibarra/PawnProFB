from app.database import get_db

class Item:
    @staticmethod
    def get_all(search=None, status=None, category_id=None):
        db = get_db()
        cur = db.cursor()
        conditions = []
        params = []
        if search:
            conditions.append("(UPPER(I.NAME) LIKE ? OR UPPER(I.BRAND) LIKE ? OR UPPER(I.MODEL) LIKE ? OR UPPER(I.SERIAL_NUMBER) LIKE ?)")
            s = f'%{search.upper()}%'
            params.extend([s, s, s, s])
        if status:
            conditions.append("I.STATUS = ?")
            params.append(status)
        if category_id:
            conditions.append("I.CATEGORY_ID = ?")
            params.append(category_id)
        where = "WHERE " + " AND ".join(conditions) if conditions else ""
        cur.execute(
            f"SELECT I.ITEM_ID, I.CATEGORY_ID, C.NAME as CATEGORY_NAME, I.NAME, I.DESCRIPTION, "
            f"I.SERIAL_NUMBER, I.BRAND, I.MODEL, I.CONDITION, I.STATUS, I.APPRAISED_VALUE, I.CREATED_AT "
            f"FROM ITEMS I LEFT JOIN CATEGORIES C ON I.CATEGORY_ID = C.CATEGORY_ID {where} ORDER BY I.CREATED_AT DESC",
            params
        )
        columns = [desc[0].lower() for desc in cur.description]
        return [dict(zip(columns, row)) for row in cur.fetchall()]

    @staticmethod
    def get_by_id(item_id):
        db = get_db()
        cur = db.cursor()
        cur.execute(
            "SELECT I.ITEM_ID, I.CATEGORY_ID, C.NAME as CATEGORY_NAME, I.NAME, I.DESCRIPTION, "
            "I.SERIAL_NUMBER, I.BRAND, I.MODEL, I.CONDITION, I.STATUS, I.APPRAISED_VALUE, I.CREATED_AT "
            "FROM ITEMS I LEFT JOIN CATEGORIES C ON I.CATEGORY_ID = C.CATEGORY_ID WHERE I.ITEM_ID = ?",
            (item_id,)
        )
        columns = [desc[0].lower() for desc in cur.description]
        row = cur.fetchone()
        return dict(zip(columns, row)) if row else None

    @staticmethod
    def get_available():
        db = get_db()
        cur = db.cursor()
        cur.execute(
            "SELECT I.ITEM_ID, I.NAME, I.BRAND, I.MODEL, I.CONDITION, I.APPRAISED_VALUE, C.NAME as CATEGORY_NAME "
            "FROM ITEMS I LEFT JOIN CATEGORIES C ON I.CATEGORY_ID = C.CATEGORY_ID "
            "WHERE I.STATUS = 'Available' ORDER BY I.NAME"
        )
        columns = [desc[0].lower() for desc in cur.description]
        return [dict(zip(columns, row)) for row in cur.fetchall()]

    @staticmethod
    def create(category_id, name, description, serial_number, brand, model, condition, appraised_value):
        db = get_db()
        cur = db.cursor()
        cur.execute(
            "INSERT INTO ITEMS (CATEGORY_ID, NAME, DESCRIPTION, SERIAL_NUMBER, BRAND, MODEL, CONDITION, APPRAISED_VALUE) "
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING ITEM_ID",
            (category_id, name, description, serial_number, brand, model, condition, appraised_value)
        )
        row = cur.fetchone()
        db.commit()
        return row[0] if row else None

    @staticmethod
    def update(item_id, category_id, name, description, serial_number, brand, model, condition, appraised_value, status):
        db = get_db()
        cur = db.cursor()
        cur.execute(
            "UPDATE ITEMS SET CATEGORY_ID=?, NAME=?, DESCRIPTION=?, SERIAL_NUMBER=?, BRAND=?, MODEL=?, "
            "CONDITION=?, APPRAISED_VALUE=?, STATUS=? WHERE ITEM_ID=?",
            (category_id, name, description, serial_number, brand, model, condition, appraised_value, status, item_id)
        )
        db.commit()

    @staticmethod
    def update_status(item_id, status):
        db = get_db()
        cur = db.cursor()
        cur.execute("UPDATE ITEMS SET STATUS=? WHERE ITEM_ID=?", (status, item_id))
        db.commit()

    @staticmethod
    def delete(item_id):
        db = get_db()
        cur = db.cursor()
        cur.execute("DELETE FROM ITEMS WHERE ITEM_ID = ?", (item_id,))
        db.commit()

    @staticmethod
    def get_categories():
        db = get_db()
        cur = db.cursor()
        cur.execute("SELECT CATEGORY_ID, NAME, DESCRIPTION FROM CATEGORIES ORDER BY NAME")
        columns = [desc[0].lower() for desc in cur.description]
        return [dict(zip(columns, row)) for row in cur.fetchall()]
