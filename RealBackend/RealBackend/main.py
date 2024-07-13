from flask import Flask, jsonify, request
from database.cartStorage import CartDatabase
app = Flask(__name__)


@app.route('/getItems', methods=['GET', 'POST'])
def home():
    if request.method == 'GET':
        database = CartDatabase('./database/database.json')
        return jsonify({'data': database.load_cart_items()})


if __name__ == '__main__':
    app.run(debug=True)
