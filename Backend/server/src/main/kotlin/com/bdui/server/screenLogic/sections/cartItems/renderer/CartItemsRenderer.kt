package com.bdui.server.screenLogic.sections.cartItems.renderer

import color
import com.bdui.server.jto.View
import com.bdui.server.jto.container
import com.bdui.server.jto.model.insets.edgeInsets
import com.bdui.server.jto.model.vertical
import com.bdui.server.jto.singleState
import com.bdui.server.jto.text
import com.bdui.server.jto.ui
import com.bdui.server.jto.view
import com.bdui.server.screenLogic.sections.cartItems.context.CartItemsRenderContext
import java.awt.Color
import java.util.UUID

object CartItemsRenderer {
    fun render(renderContext: CartItemsRenderContext): View {
        return ui {
            view(
                id = "cart-title-snippet-id-${UUID.randomUUID()}",
                states = singleState(
                    div = container(
                        orientation = vertical,
                        backgroundColor = color(Color.lightGray),
                        padding = edgeInsets(top = 10),
                        items = listOf(
                            text("wafda")
                        )
                    )
                )
            )
        }
    }
}