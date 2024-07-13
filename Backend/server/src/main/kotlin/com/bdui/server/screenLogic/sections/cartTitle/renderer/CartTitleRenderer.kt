package com.bdui.server.screenLogic.sections.cartTitle.renderer

import color
import com.bdui.server.actions.PrintAction
import com.bdui.server.jto.Div
import com.bdui.server.jto.UiNamespace
import com.bdui.server.jto.View
import com.bdui.server.jto.action
import com.bdui.server.jto.container
import com.bdui.server.jto.model.cornerRadius.cornerRadius
import com.bdui.server.jto.model.firstTextBaseline
import com.bdui.server.jto.model.horizontal
import com.bdui.server.jto.model.insets.edgeInsets
import com.bdui.server.jto.model.left
import com.bdui.server.jto.model.vertical
import com.bdui.server.jto.singleState
import com.bdui.server.jto.text
import com.bdui.server.jto.ui
import com.bdui.server.jto.view
import com.bdui.server.screenLogic.sections.cartTitle.context.CartTitleRenderContext
import java.awt.Color
import java.util.UUID

object CartTitleRenderer {
    fun render(renderContext: CartTitleRenderContext): View {
        return ui {
            view(
                id = "cart-title-snippet-id-${UUID.randomUUID()}",
                states = singleState(
                    div = container(
                        orientation = vertical,
                        backgroundColor = color(Color.lightGray),
                        padding = edgeInsets(top = 10),
                        items = listOf(
                            renderTitleContainer(renderContext)
                        )
                    )
                )
            )
        }
    }

    private fun UiNamespace.renderTitleContainer(renderContext: CartTitleRenderContext): Div {
        return container(
            orientation = horizontal,
            verticalAlignment = firstTextBaseline,
            cornerRadius = cornerRadius(
                topLeading = 20.0F,
                topTrailing = 20.0F
            ),
            padding = edgeInsets(top = 10),
            horizontalAlignment = left,
            items = listOfNotNull(
                text(
                    text = "Cart",
                    fontSize = 24,
                    padding = edgeInsets(left = 16),
                ),
                text(
                    text = "${renderContext.available} available",
                    padding = edgeInsets(left = 10)
                ),
                text(
                    text = "•",
                    padding = edgeInsets(left = 4)
                ).takeIf { renderContext.unavailable != null },
                text(
                    text = "${renderContext.unavailable} unavailable",
                    padding = edgeInsets(left = 4)
                ).takeIf { renderContext.unavailable != null }
            )
        )
    }
}
