import os
import warnings

_DEFAULT_SECRET_KEY = 'dev-secret-key-change-in-production'
_DEFAULT_FB_PASSWORD = 'masterkey'


class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or _DEFAULT_SECRET_KEY
    FIREBIRD_HOST = os.environ.get('FIREBIRD_HOST') or 'localhost'
    FIREBIRD_PORT = int(os.environ.get('FIREBIRD_PORT') or 3050)
    FIREBIRD_DATABASE = os.environ.get('FIREBIRD_DATABASE') or '/var/lib/firebird/5.0/data/pawnpro.fdb'
    FIREBIRD_USER = os.environ.get('FIREBIRD_USER') or 'SYSDBA'
    FIREBIRD_PASSWORD = os.environ.get('FIREBIRD_PASSWORD') or _DEFAULT_FB_PASSWORD
    FIREBIRD_CHARSET = 'UTF8'
    ITEMS_PER_PAGE = 20

    def __init_subclass__(cls, **kwargs):
        super().__init_subclass__(**kwargs)

    @classmethod
    def validate(cls):
        if cls.SECRET_KEY == _DEFAULT_SECRET_KEY:
            warnings.warn(
                "SECRET_KEY is using the insecure default. Set the SECRET_KEY environment variable before deploying to production.",
                stacklevel=2,
            )
        if cls.FIREBIRD_PASSWORD == _DEFAULT_FB_PASSWORD:
            warnings.warn(
                "FIREBIRD_PASSWORD is using the insecure default 'masterkey'. Set the FIREBIRD_PASSWORD environment variable before deploying to production.",
                stacklevel=2,
            )
