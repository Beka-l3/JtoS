package com.bdui.server.screenLogic.api

import com.fasterxml.jackson.annotation.JsonProperty

data class CartItem(
    val id: Int,
    val name: String,
    @JsonProperty("shop_name")
    val shopName: String,
    val price: Double,
    val count: Int,
    @JsonProperty("is_selected_state")
    val isSelected: Boolean,
    @JsonProperty("image_url")
    val imageUrl: String,
    @JsonProperty("is_available_state")
    val isAvailable: Boolean
)
