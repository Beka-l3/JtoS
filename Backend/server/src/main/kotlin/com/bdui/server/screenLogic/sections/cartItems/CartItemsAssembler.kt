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
        val render1 = CartItemsRenderer.render(renderContext)
        val render2 = CartItemsRenderer.render(renderContext)
        val render3 = CartItemsRenderer.render(renderContext)

        return listOf(
            render1,
            render2,
            render3
        )
    }
}
