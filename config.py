import os

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'dev-secret-key-change-in-production'
    FIREBIRD_HOST = os.environ.get('FIREBIRD_HOST') or 'localhost'
    FIREBIRD_PORT = int(os.environ.get('FIREBIRD_PORT') or 3050)
    FIREBIRD_DATABASE = os.environ.get('FIREBIRD_DATABASE') or '/var/lib/firebird/5.0/data/pawnpro.fdb'
    FIREBIRD_USER = os.environ.get('FIREBIRD_USER') or 'SYSDBA'
    FIREBIRD_PASSWORD = os.environ.get('FIREBIRD_PASSWORD') or 'masterkey'
    FIREBIRD_CHARSET = 'UTF8'
    ITEMS_PER_PAGE = 20
