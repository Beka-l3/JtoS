package com.bdui.server.screenLogic.api

import com.fasterxml.jackson.annotation.JsonProperty

data class CartItem(
    val id: Int,
    val name: String,
    @JsonProperty("shopName")
    val shopName: String,
    val price: Double,
    val count: Int,
    @JsonProperty("isSelectedState")
    val isSelectedState: Boolean,
    @JsonProperty("imageUrl")
    val imageUrl: String,
    @JsonProperty("isAvailableState")
    val isAvailableState: Boolean
)
