from flask import Blueprint, render_template, request, redirect, url_for, flash
from app.models.sale import Sale
from app.models.item import Item
from app.models.customer import Customer
from datetime import date

bp = Blueprint('sales', __name__)

@bp.route('/')
def list():
    search = request.args.get('search', '')
    sales = Sale.get_all(search=search if search else None)
    return render_template('sales/list.html', sales=sales, search=search)

@bp.route('/add', methods=['GET', 'POST'])
def add():
    items = Item.get_all(status='For Sale') + Item.get_all(status='Available')
    customers = Customer.get_all()
    if request.method == 'POST':
        item_id = request.form.get('item_id')
        sale_price = request.form.get('sale_price')
        sale_date = request.form.get('sale_date', date.today().isoformat())
        customer_id = request.form.get('customer_id') or None
        notes = request.form.get('notes', '').strip()
        if not item_id or not sale_price:
            flash('Item and sale price are required.', 'danger')
            return render_template('sales/form.html', items=items, customers=customers, form=request.form)
        Sale.create(int(item_id), int(customer_id) if customer_id else None,
                    float(sale_price), sale_date, notes)
        flash('Sale recorded successfully.', 'success')
        return redirect(url_for('sales.list'))
    return render_template('sales/form.html', items=items, customers=customers,
                           form={'sale_date': date.today().isoformat()})
