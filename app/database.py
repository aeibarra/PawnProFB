import firebird.driver as fdb
from flask import g, current_app

def get_db():
    if 'db' not in g:
        app = current_app
        g.db = fdb.connect(
            host=app.config['FIREBIRD_HOST'],
            port=app.config['FIREBIRD_PORT'],
            database=app.config['FIREBIRD_DATABASE'],
            user=app.config['FIREBIRD_USER'],
            password=app.config['FIREBIRD_PASSWORD'],
            charset=app.config['FIREBIRD_CHARSET']
        )
    return g.db

def close_db(e=None):
    db = g.pop('db', None)
    if db is not None:
        db.close()

def init_app(app):
    app.teardown_appcontext(close_db)
