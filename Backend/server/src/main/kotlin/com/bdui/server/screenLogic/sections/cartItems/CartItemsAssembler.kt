package com.bdui.server.screenLogic.sections.cartItems

import com.bdui.server.bdui.core.abstract.AbstractAssembler
import com.bdui.server.bdui.core.abstract.AbstractSection
import com.bdui.server.jto.View
import com.bdui.server.screenLogic.api.CartResponse
import com.bdui.server.screenLogic.sections.cartItems.mapper.CartItemsMapper
import com.bdui.server.screenLogic.sections.cartItems.renderer.CartItemsRenderer

class CartItemsAssembler: AbstractAssembler() {
    override fun getName(): String {
        return "CartItemsAssembler"
    }

    override fun convert(section: AbstractSection): List<View> {
        val cartResponse = section.resolverRespone as? CartResponse ?: return emptyList()
        val renderContext = CartItemsMapper.map(cartResponse)
        val renderedItems = renderContext.items.map { CartItemsRenderer.render(it) }

        return renderedItems
    }
}
