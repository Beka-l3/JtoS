package com.bdui.server.screenLogic.sections.cartTitle

import com.bdui.server.bdui.core.abstract.AbstractAssembler
import com.bdui.server.bdui.core.abstract.AbstractSection
import com.bdui.server.jto.View
import com.bdui.server.screenLogic.api.CartResponse
import com.bdui.server.screenLogic.sections.cartTitle.mapper.CartTitleMapper
import com.bdui.server.screenLogic.sections.cartTitle.renderer.CartTitleRenderer

class CartTitleAssembler: AbstractAssembler() {
    override fun getName(): String {
        return "CartTitleAssembler"
    }

    override fun convert(section: AbstractSection): List<View> {
        val cartResponse = section.resolverRespone as? CartResponse ?: return emptyList()
        val renderContext = CartTitleMapper.map(cartResponse)
        val render = CartTitleRenderer.render(renderContext)
        return listOf(render)
    }
}