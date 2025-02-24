from app1 import db, app

with app.app_context():
    db.create_all()
    print("Database initialized!")