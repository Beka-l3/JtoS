import json
from model.cartItem import CartItem
from typing import Optional, List


class CartDatabase:
    def __init__(self, file_path):
        self.file_path = file_path

    def read_cart_items(self) -> List[CartItem]:
        try:
            with open(self.file_path, 'r') as file:
                data = json.load(file)
                cart_items = [CartItem(**item) for item in data]
                return cart_items
        except FileNotFoundError:
            return []

    def update_cart_item(self, new_cart_item: CartItem):
        cart_items = self.read_cart_items()
        for i, item in enumerate(cart_items):
            if item.id == new_cart_item.id:
                cart_items[i] = new_cart_item
                break
        self.update_cart_items(cart_items)

    def update_cart_items(self, cart_items: List[CartItem]):
        try:
            with open(self.file_path, 'w') as file:
                data = [item.serialize() for item in cart_items]
                json.dump(data, file, indent=4, sort_keys=True)
        except FileNotFoundError:
            return
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