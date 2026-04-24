from flask import Blueprint, render_template, request, redirect, url_for, flash
from app.models.transaction import Transaction
from app.models.customer import Customer
from app.models.item import Item
from datetime import date, timedelta

bp = Blueprint('transactions', __name__)

@bp.route('/')
def list():
    status = request.args.get('status', '')
    search = request.args.get('search', '')
    transactions = Transaction.get_all(
        status=status if status else None,
        search=search if search else None
    )
    return render_template('transactions/list.html', transactions=transactions, status=status, search=search)

@bp.route('/add', methods=['GET', 'POST'])
def add():
    customers = Customer.get_all()
    items = Item.get_available()
    if request.method == 'POST':
        customer_id = request.form.get('customer_id')
        loan_amount = request.form.get('loan_amount')
        interest_rate = request.form.get('interest_rate', '10')
        due_date = request.form.get('due_date')
        item_ids = request.form.getlist('item_ids')
        notes = request.form.get('notes', '').strip()
        if not customer_id or not loan_amount or not due_date:
            flash('Customer, loan amount, and due date are required.', 'danger')
            return render_template('transactions/form.html', customers=customers, items=items,
                                   form=request.form)
        transaction_id = Transaction.create(
            int(customer_id), float(loan_amount), float(interest_rate),
            due_date, [int(i) for i in item_ids], notes
        )
        flash('Pawn transaction created successfully.', 'success')
        return redirect(url_for('transactions.view', transaction_id=transaction_id))
    default_due_date = (date.today() + timedelta(days=30)).isoformat()
    return render_template('transactions/form.html', customers=customers, items=items,
                           form={'interest_rate': '10', 'due_date': default_due_date})

@bp.route('/<int:transaction_id>')
def view(transaction_id):
    transaction = Transaction.get_by_id(transaction_id)
    if not transaction:
        flash('Transaction not found.', 'danger')
        return redirect(url_for('transactions.list'))
    items = Transaction.get_items(transaction_id)
    return render_template('transactions/view.html', transaction=transaction, items=items)

@bp.route('/<int:transaction_id>/redeem', methods=['POST'])
def redeem(transaction_id):
    Transaction.update_status(transaction_id, 'Redeemed')
    flash('Transaction marked as Redeemed.', 'success')
    return redirect(url_for('transactions.view', transaction_id=transaction_id))

@bp.route('/<int:transaction_id>/forfeit', methods=['POST'])
def forfeit(transaction_id):
    Transaction.update_status(transaction_id, 'Forfeited')
    flash('Transaction marked as Forfeited. Items are now available for sale.', 'warning')
    return redirect(url_for('transactions.view', transaction_id=transaction_id))
