package com.bdui.server.screenLogic.sections.cartItems.context

import com.fasterxml.jackson.annotation.JsonProperty

data class CartItemsRenderContext(
    val items: List<CartItemRenderContext>
) {
    data class CartItemRenderContext(
        val id: Int,
        val name: String,
        val shopName: String,
        val price: Double,
        val count: Int,
        val isSelected: Boolean,
        val imageUrl: String,
        val isAvailable: Boolean
    )
}