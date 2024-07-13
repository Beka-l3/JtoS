import json
from model.cartItem import CartItem
class CartDatabase:
    def __init__(self, file_path):
        self.file_path = file_path

    def load_cart_items(self):
        try:
            with open(self.file_path, 'r') as file:
                data = json.load(file)
                cart_items = [CartItem(**item).serialize() for item in data]
                return cart_items
        except FileNotFoundError:
            return []

    # def save_cart_items(self, cart_items):
    #     data = [item.to_dict() for item in cart_items]
    #     with open(self.file_path, 'w') as file:
    #         json.dump(data, file)
    #
    # def add_cart_item(self, cart_item):
    #     cart_items = self.load_cart_items()
    #     cart_items.append(cart_item)
    #     self.save_cart_items(cart_items)
    #
    # def remove_cart_item(self, cart_item):
    #     cart_items = self.load_cart_items()
    #     cart_items = [item for item in cart_items if item.name != cart_item.name]
    #     self.save_cart_items(cart_items)
    #
    # def update_cart_item(self, cart_item):
    #     cart_items = self.load_cart_items()
    #     for i, item in enumerate(cart_items):
    #         if item.name == cart_item.name:
    #             cart_items[i] = cart_item
    #             break
    #     self.save_cart_items(cart_items)