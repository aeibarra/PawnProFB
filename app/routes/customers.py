from flask import Blueprint, render_template, request, redirect, url_for, flash
from app.models.customer import Customer

bp = Blueprint('customers', __name__)

@bp.route('/')
def list():
    search = request.args.get('search', '')
    customers = Customer.get_all(search=search if search else None)
    return render_template('customers/list.html', customers=customers, search=search)

@bp.route('/add', methods=['GET', 'POST'])
def add():
    if request.method == 'POST':
        first_name = request.form.get('first_name', '').strip()
        last_name = request.form.get('last_name', '').strip()
        if not first_name or not last_name:
            flash('First name and last name are required.', 'danger')
            return render_template('customers/form.html', customer=request.form, action='add')
        Customer.create(
            first_name, last_name,
            request.form.get('phone', '').strip(),
            request.form.get('email', '').strip(),
            request.form.get('address', '').strip(),
            request.form.get('id_type', '').strip(),
            request.form.get('id_number', '').strip(),
            request.form.get('notes', '').strip()
        )
        flash('Customer added successfully.', 'success')
        return redirect(url_for('customers.list'))
    return render_template('customers/form.html', customer=None, action='add')

@bp.route('/<int:customer_id>')
def view(customer_id):
    customer = Customer.get_by_id(customer_id)
    if not customer:
        flash('Customer not found.', 'danger')
        return redirect(url_for('customers.list'))
    return render_template('customers/view.html', customer=customer)

@bp.route('/<int:customer_id>/edit', methods=['GET', 'POST'])
def edit(customer_id):
    customer = Customer.get_by_id(customer_id)
    if not customer:
        flash('Customer not found.', 'danger')
        return redirect(url_for('customers.list'))
    if request.method == 'POST':
        first_name = request.form.get('first_name', '').strip()
        last_name = request.form.get('last_name', '').strip()
        if not first_name or not last_name:
            flash('First name and last name are required.', 'danger')
            return render_template('customers/form.html', customer=request.form, action='edit', customer_id=customer_id)
        Customer.update(
            customer_id, first_name, last_name,
            request.form.get('phone', '').strip(),
            request.form.get('email', '').strip(),
            request.form.get('address', '').strip(),
            request.form.get('id_type', '').strip(),
            request.form.get('id_number', '').strip(),
            request.form.get('notes', '').strip()
        )
        flash('Customer updated successfully.', 'success')
        return redirect(url_for('customers.view', customer_id=customer_id))
    return render_template('customers/form.html', customer=customer, action='edit', customer_id=customer_id)

@bp.route('/<int:customer_id>/delete', methods=['POST'])
def delete(customer_id):
    Customer.delete(customer_id)
    flash('Customer deleted successfully.', 'success')
    return redirect(url_for('customers.list'))
