from flask import Flask, jsonify, request
from database.cartStorage import CartDatabase
from patch.PatchDispatcher import PatchDispatcher
app = Flask(__name__)


@app.route('/getItems', methods=['GET', 'POST'])
def getItems():
    database = CartDatabase('./database/database.json')
    return __getItems__(database)

@app.route('/patch', methods=['POST'])
def patch():
    body = request.json
    database = CartDatabase('./database/database.json')
    PatchDispatcher.map(body, database)
    return __getItems__(database)


def __getItems__(database: CartDatabase):
    cart_items = database.read_cart_items()
    serialized_data = [item.serialize() for item in cart_items]
    return jsonify({'data': serialized_data})

if __name__ == '__main__':
    app.run(debug=True)
