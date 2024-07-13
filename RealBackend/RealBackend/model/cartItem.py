class CartItem:
    def __init__(self, id, name, shop_name, price, count, is_selected_state, image_url, is_available_state):
        self.id = id
        self.name = name
        self.shop_name = shop_name
        self.price = price
        self.count = count
        self.is_selected_state = is_selected_state
        self.image_url = image_url
        self.is_available_state = is_available_state

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'shop_name': self.shop_name,
            'price': self.price,
            'count': self.count,
            'is_selected_state': self.is_selected_state,
            'image_url': self.image_url,
            'is_available_state': self.is_available_state
        }

    def serialize_for_frontend(self):
        return {
            'id': self.id,
            'name': self.name,
            'shop_name': self.shop_name,
            'price': round(self.price * self.count, 2),
            'count': self.count,
            'is_selected_state': self.is_selected_state,
            'image_url': self.image_url,
            'is_available_state': self.is_available_state
        }
    @classmethod
    def from_dict(cls, data):
        return cls(
            id=data['id'],
            name=data['name'],
            shop_name=data['shop_name'],
            price=data['price'],
            count=data['count'],
            is_selected_state=data['is_selected_state'],
            image_url=data['image_url'],
            is_available_state=data['is_available_state']
        )
