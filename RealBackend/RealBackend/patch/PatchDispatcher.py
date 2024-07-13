from database.cartStorage import CartDatabase
from model.cartItem import CartItem


class PatchDispatcher:
    @classmethod
    def map(cls, body, database: CartDatabase):
        patch_type = body['patchType']
        if patch_type == 'ChangeCounterPatch':
            cls.__map_change_counter_patch__(body, database)
        else:
            return

    @classmethod
    def __map_change_counter_patch__(cls, body, database: CartDatabase):
        target_id = int(body['targetId'])
        new_value = body['newValue']
        cart_items = database.read_cart_items()

        cart_item: CartItem = None
        for item in cart_items:
            if item.id == target_id:
                cart_item = item
                break

        newCartItem = CartItem(
            id=cart_item.id,
            name=cart_item.name,
            shop_name=cart_item.shop_name,
            price=cart_item.price,
            count=int(new_value),
            is_selected_state=cart_item.is_selected_state,
            image_url=cart_item.image_url,
            is_available_state=cart_item.is_available_state
        )
        database.update_cart_item(newCartItem)