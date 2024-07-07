package com.bdui.server.screenLogic.sections.cartItems

import com.bdui.server.bdui.core.abstract.AbstractAssembler
import com.bdui.server.bdui.core.abstract.AbstractSection
import com.bdui.server.jto.View
import com.bdui.server.screenLogic.sections.cartItems.mapper.CartItemsMapper
import com.bdui.server.screenLogic.sections.cartItems.renderer.CartItemsRenderer

class CartItemsAssembler: AbstractAssembler() {
    override fun getName(): String {
        return "CartItemsAssembler"
    }

    override fun convert(section: AbstractSection): List<View> {
        val renderContext = CartItemsMapper.map()
        val render = CartItemsRenderer.render(renderContext)
        return listOf(render)
    }
}