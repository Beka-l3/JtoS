from database.cartStorage import CartDatabase
from model.cartItem import CartItem


class PatchDispatcher:
    @classmethod
    def map(cls, body, database: CartDatabase):
        patch_type = body['patchType']
        if patch_type == 'ChangeCounterPatch':
            cls.__map_change_counter_patch__(body, database)
        elif patch_type == 'ChangeIsSelectedPatch':
            cls.__map_change_is_selected_patch__(body, database)
        elif patch_type == 'ChooseAlPatch':
            cls.__map_choose_all_patch__(body, database)
        else:
            return

    @classmethod
    def __map_change_counter_patch__(cls, body, database: CartDatabase):
        target_id = int(body['targetId'])
        new_value = int(body['newValue'])
        cart_items = database.read_cart_items()

        cart_item: CartItem = None
        for item in cart_items:
            if item.id == target_id:
                cart_item = item
                break

        if new_value > 0:
            new_count = new_value
        else:
            new_count = int(cart_item.count)
        new_cart_item = CartItem(
            id=cart_item.id,
            name=cart_item.name,
            shop_name=cart_item.shop_name,
            price=cart_item.price,
            count=new_count,
            is_selected_state=cart_item.is_selected_state,
            image_url=cart_item.image_url,
            is_available_state=cart_item.is_available_state
        )
        database.update_cart_item(new_cart_item)

    @classmethod
    def __map_change_is_selected_patch__(cls, body, database: CartDatabase):
        target_id = int(body['targetId'])
        new_value = bool(body['newValue'] == 'true')
        cart_items = database.read_cart_items()

        cart_item: CartItem = None
        for item in cart_items:
            if item.id == target_id:
                cart_item = item
                break

        new_cart_item = CartItem(
            id=cart_item.id,
            name=cart_item.name,
            shop_name=cart_item.shop_name,
            price=cart_item.price,
            count=cart_item.count,
            is_selected_state=new_value,
            image_url=cart_item.image_url,
            is_available_state=cart_item.is_available_state
        )
        database.update_cart_item(new_cart_item)

    @classmethod
    def __map_choose_all_patch__(cls, body, database: CartDatabase):
        cart_items = database.read_cart_items()

        isSomeNotSelected = False

        for item in cart_items:
            if item.is_selected_state == False:
                isSomeNotSelected = True
                break

        new_cart_items = list(map(lambda item: CartItem(
            id=item.id,
            name=item.name,
            shop_name=item.shop_name,
            price=item.price,
            count=item.count,
            is_selected_state=isSomeNotSelected,
            image_url=item.image_url,
            is_available_state=item.is_available_state
        ), cart_items))

        database.update_cart_items(new_cart_items)