package com.bdui.server.screenLogic.sections.cartControls

import com.bdui.server.bdui.core.abstract.AbstractAssembler
import com.bdui.server.bdui.core.abstract.AbstractSection
import com.bdui.server.jto.View
import com.bdui.server.screenLogic.sections.cartControls.mapper.CartControlsMapper
import com.bdui.server.screenLogic.sections.cartControls.renderer.CartControlsRenderer

class CartControlsAssembler: AbstractAssembler() {
    override fun getName(): String {
        return "CartControlsAssembler"
    }

    override fun convert(section: AbstractSection): List<View> {
        val renderContext = CartControlsMapper.map()
        val render = CartControlsRenderer.render(renderContext)
        return listOf(render)
    }
}