from flask import Blueprint, render_template, request, redirect, url_for, flash
from app.models.item import Item

bp = Blueprint('items', __name__)

@bp.route('/')
def list():
    search = request.args.get('search', '')
    status = request.args.get('status', '')
    category_id = request.args.get('category_id', '')
    items = Item.get_all(
        search=search if search else None,
        status=status if status else None,
        category_id=int(category_id) if category_id else None
    )
    categories = Item.get_categories()
    return render_template('items/list.html', items=items, categories=categories,
                           search=search, status=status, category_id=category_id)

@bp.route('/add', methods=['GET', 'POST'])
def add():
    categories = Item.get_categories()
    if request.method == 'POST':
        name = request.form.get('name', '').strip()
        if not name:
            flash('Item name is required.', 'danger')
            return render_template('items/form.html', item=request.form, categories=categories, action='add')
        appraised_value = request.form.get('appraised_value') or None
        Item.create(
            request.form.get('category_id') or None,
            name,
            request.form.get('description', '').strip(),
            request.form.get('serial_number', '').strip(),
            request.form.get('brand', '').strip(),
            request.form.get('model', '').strip(),
            request.form.get('condition', 'Good'),
            float(appraised_value) if appraised_value else None
        )
        flash('Item added successfully.', 'success')
        return redirect(url_for('items.list'))
    return render_template('items/form.html', item=None, categories=categories, action='add')

@bp.route('/<int:item_id>/edit', methods=['GET', 'POST'])
def edit(item_id):
    item = Item.get_by_id(item_id)
    categories = Item.get_categories()
    if not item:
        flash('Item not found.', 'danger')
        return redirect(url_for('items.list'))
    if request.method == 'POST':
        name = request.form.get('name', '').strip()
        if not name:
            flash('Item name is required.', 'danger')
            return render_template('items/form.html', item=request.form, categories=categories, action='edit', item_id=item_id)
        appraised_value = request.form.get('appraised_value') or None
        Item.update(
            item_id,
            request.form.get('category_id') or None,
            name,
            request.form.get('description', '').strip(),
            request.form.get('serial_number', '').strip(),
            request.form.get('brand', '').strip(),
            request.form.get('model', '').strip(),
            request.form.get('condition', 'Good'),
            float(appraised_value) if appraised_value else None,
            request.form.get('status', 'Available')
        )
        flash('Item updated successfully.', 'success')
        return redirect(url_for('items.list'))
    return render_template('items/form.html', item=item, categories=categories, action='edit', item_id=item_id)

@bp.route('/<int:item_id>/delete', methods=['POST'])
def delete(item_id):
    Item.delete(item_id)
    flash('Item deleted successfully.', 'success')
    return redirect(url_for('items.list'))
