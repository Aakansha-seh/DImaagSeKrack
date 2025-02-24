from flask import render_template, redirect, url_for, request, flash, session
from . import app, db
from .models import User, Item  # Ensure Item is imported here
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
import os

@app.route('/')
def welcome():
    return render_template('index.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = User.query.filter_by(username=username).first()
        if user and check_password_hash(user.password, password):
            session['user_id'] = user.id
            flash('Login successful!', 'success')
            return redirect(url_for('main'))
        else:
            flash('Login unsuccessful. Please check username and password', 'danger')
    return render_template('login.html')

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        existing_user = User.query.filter((User.username == username) | (User.email == email)).first()
        if existing_user:
            flash('Username or email already exists. Please choose a different one.', 'danger')
        else:
            hashed_password = generate_password_hash(password, method='pbkdf2:sha256')
            new_user = User(username=username, email=email, password=hashed_password)
            db.session.add(new_user)
            db.session.commit()
            flash('Your account has been created! You can now log in', 'success')
            return redirect(url_for('login'))
    return render_template('signup.html')

@app.route('/main')
def main():
    items = Item.query.all()
    return render_template('main.html', items=items)

@app.route('/profile')
def profile():
    user_id = session.get('user_id')
    if not user_id:
        flash('Please log in to view your profile.', 'danger')
        return redirect(url_for('login'))
    user = User.query.get(user_id)
    return render_template('profile.html', user=user)

@app.route('/edit_profile', methods=['POST'])
def edit_profile():
    user_id = session.get('user_id')
    if not user_id:
        flash('Please log in to edit your profile.', 'danger')
        return redirect(url_for('login'))
    user = User.query.get(user_id)
    user.first_name = request.form['first_name']
    user.last_name = request.form['last_name']
    user.address = request.form['address']
    user.pin_code = request.form['pin_code']
    user.mobile = request.form['mobile']
    db.session.commit()
    flash('Profile updated successfully!', 'success')
    return redirect(url_for('profile'))

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    flash('You have been logged out.', 'success')
    return redirect(url_for('welcome'))

@app.route('/sell_item', methods=['POST'])
def sell_item():
    user_id = session.get('user_id')
    if not user_id:
        flash('Please log in to sell an item.', 'danger')
        return redirect(url_for('login'))
    item_name = request.form['item_name']
    description = request.form['description']
    price = request.form['price']
    category = request.form['category']
    image = request.files['image']
    filename = secure_filename(image.filename)
    image.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    new_item = Item(name=item_name, description=description, price=price, category=category, image=filename, user_id=user_id)
    db.session.add(new_item)
    db.session.commit()
    flash('Item listed successfully!', 'success')
    return redirect(url_for('main'))

@app.route('/cart')
def cart():
    cart_items = session.get('cart', [])
    return render_template('cart.html', cart_items=cart_items)

@app.route('/add_to_cart', methods=['POST'])
def add_to_cart():
    item_name = request.form['item_name']
    if 'cart' not in session:
        session['cart'] = []
    session['cart'].append(item_name)
    flash(f'{item_name} added to cart!', 'success')
    return redirect(url_for('main'))

@app.route('/buy_now/<item_name>')
def buy_now(item_name):
    item = {
        'Book': {'price': 10, 'image': 'book.jpg'},
        'Mattress': {'price': 50, 'image': 'mattress.jpg'},
        'Clothes': {'price': 20, 'image': 'clothes.jpg'},
        'Shoes': {'price': 30, 'image': 'shoes.jpg'},
        'Laptop': {'price': 300, 'image': 'laptop.jpg'},
        'Phone': {'price': 200, 'image': 'phone.jpg'}
    }.get(item_name, {'price': 0, 'image': 'placeholder.jpg'})
    return render_template('buy_now.html', item_name=item_name, item=item)