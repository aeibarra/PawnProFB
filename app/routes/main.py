from flask import Blueprint, render_template
from app.models.customer import Customer
from app.models.item import Item
from app.models.transaction import Transaction
from app.models.sale import Sale

bp = Blueprint('main', __name__)

@bp.route('/')
def dashboard():
    try:
        stats = {
            'total_customers': len(Customer.get_all()),
            'total_items': len(Item.get_all()),
            'active_transactions': len(Transaction.get_all(status='Active')),
            'overdue_transactions': Transaction.get_overdue(),
            'total_revenue': Sale.get_total_revenue(),
            'monthly_revenue': Sale.get_monthly_revenue(),
            'transaction_counts': Transaction.get_counts_by_status(),
            'recent_transactions': Transaction.get_all()[:5],
        }
    except Exception:
        stats = {
            'total_customers': 0, 'total_items': 0, 'active_transactions': 0,
            'overdue_transactions': 0, 'total_revenue': 0.0, 'monthly_revenue': 0.0,
            'transaction_counts': {}, 'recent_transactions': [],
        }
    return render_template('dashboard.html', stats=stats)
