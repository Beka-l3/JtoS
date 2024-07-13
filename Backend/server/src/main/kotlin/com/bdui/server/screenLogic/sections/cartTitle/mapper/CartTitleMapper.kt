package com.bdui.server.screenLogic.sections.cartTitle.mapper

import com.bdui.server.screenLogic.api.CartResponse
import com.bdui.server.screenLogic.sections.cartTitle.context.CartTitleRenderContext

object CartTitleMapper {

    fun map(response: CartResponse): CartTitleRenderContext {
        return CartTitleRenderContext(
            available = response.data.filter { it.isAvailable }.size,
            unavailable = response.data.filter { !it.isAvailable }.size
        )
    }

}