from flask import Flask
from config import Config
from app.database import init_app as init_db

def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)

    init_db(app)

    from app.routes.main import bp as main_bp
    app.register_blueprint(main_bp)

    from app.routes.customers import bp as customers_bp
    app.register_blueprint(customers_bp, url_prefix='/customers')

    from app.routes.items import bp as items_bp
    app.register_blueprint(items_bp, url_prefix='/items')

    from app.routes.transactions import bp as transactions_bp
    app.register_blueprint(transactions_bp, url_prefix='/transactions')

    from app.routes.sales import bp as sales_bp
    app.register_blueprint(sales_bp, url_prefix='/sales')

    return app
