package com.bdui.server.screenLogic.sections.cartItems.mapper

import com.bdui.server.screenLogic.api.CartItem
import com.bdui.server.screenLogic.api.CartResponse
import com.bdui.server.screenLogic.sections.cartItems.context.CartItemsRenderContext
import com.bdui.server.screenLogic.sections.cartItems.context.CartItemsRenderContext.CartItemRenderContext
object CartItemsMapper {

    fun map(cartResponse: CartResponse): CartItemsRenderContext {
        return CartItemsRenderContext(
            items = cartResponse.data.map { mapItem(it) }
        )
    }

    private fun mapItem(cartItem: CartItem): CartItemRenderContext {
        return CartItemRenderContext(
            id = cartItem.id,
            name = cartItem.name,
            shopName = cartItem.shopName,
            price = cartItem.price,
            count = cartItem.count,
            isSelected = cartItem.isSelected,
            imageUrl = cartItem.imageUrl,
            isAvailable = cartItem.isAvailable
        )
    }
}