package com.bdui.server.screenLogic.sections.cartItems.renderer

import color
import com.bdui.server.actions.ChangeIntegerStateAction
import com.bdui.server.jto.Div
import com.bdui.server.jto.UiNamespace
import com.bdui.server.jto.View
import com.bdui.server.jto.action
import com.bdui.server.jto.container
import com.bdui.server.jto.image
import com.bdui.server.jto.model.Variable.TextVariable
import com.bdui.server.jto.model.cornerRadius.cornerRadius
import com.bdui.server.jto.model.fromExisting
import com.bdui.server.jto.model.horizontal
import com.bdui.server.jto.model.insets.edgeInsets
import com.bdui.server.jto.model.integer
import com.bdui.server.jto.model.left
import com.bdui.server.jto.model.size.fixedSize
import com.bdui.server.jto.model.size.matchParentSize
import com.bdui.server.jto.model.size.wrapContentSize
import com.bdui.server.jto.model.top
import com.bdui.server.jto.model.url
import com.bdui.server.jto.model.vertical
import com.bdui.server.jto.singleState
import com.bdui.server.jto.spacer
import com.bdui.server.jto.text
import com.bdui.server.jto.ui
import com.bdui.server.jto.view
import com.bdui.server.screenLogic.sections.cartItems.context.CartItemsRenderContext.CartItemRenderContext
import java.awt.Color
import java.util.UUID

object CartItemsRenderer {
    fun render(renderContext: CartItemRenderContext): View {
        return ui {
            view(
                id = "cart-title-snippet-id-${UUID.randomUUID()}",
                states = singleState(
                    div = container(
                        orientation = horizontal,
                        padding = edgeInsets(
                            bottom = 10,
                            top = 10,
                            left = 16,
                            right = 16
                        ),
                        verticalAlignment = top,
                        items = listOf(
                            renderImage(url = renderContext.imageUrl),
                            renderItemInfoContainer(renderContext = renderContext)
                        )
                    )
                )
            )
        }
    }

    private fun UiNamespace.renderImage(url: String) : Div {
        return image(
            url(url = url),
            width = fixedSize(96),
            height = fixedSize(96)
        )
    }

    private fun UiNamespace.renderItemInfoContainer(renderContext: CartItemRenderContext) : Div {
        return container(
            width = matchParentSize(),
            height = matchParentSize(),
            orientation = vertical,
            verticalAlignment = top,
            padding = edgeInsets(left = 12),
            items = listOf(
                text(
                    text = renderContext.name,
                    width = matchParentSize(),
                    horizontalAlignment = left
                ),
                text(
                    text = renderContext.shopName,
                    width = matchParentSize(),
                    horizontalAlignment = left,
                    padding = edgeInsets(top = 12)
                ),
                renderPriceContainer(renderContext.price),
                renderControls(renderContext)
            )
        )
    }

    private fun UiNamespace.renderPriceContainer(price: Double) : Div {
        return container(
            width = matchParentSize(),
            height = wrapContentSize(),
            orientation = vertical,
            padding = edgeInsets(top = 12),
            items = listOf(
                text(
                    text = "С картой Я.Пэй",
                    width = matchParentSize(),
                    horizontalAlignment = left
                ),
                text(
                    text = "$price руб",
                    width = matchParentSize(),
                    horizontalAlignment = left,
                    padding = edgeInsets(top = 2),
                    fontSize = 18
                )
            )
        )
    }

    private fun UiNamespace.renderControls(renderContext: CartItemRenderContext) : Div {
        return container(
            width = matchParentSize(),
            height = wrapContentSize(),
            orientation = horizontal,
            padding = edgeInsets(top = 12),
            items = listOf(
                text(
                    text = "Удалить",
                    width = wrapContentSize(),
                ),
                spacer(),
                renderCounterButton(renderContext = renderContext)
            )
        )
    }

    private fun UiNamespace.renderCounterButton(renderContext: CartItemRenderContext): Div {
        return container(
            orientation = horizontal,
            width = fixedSize(96),
            height = wrapContentSize(),
            backgroundColor = color(Color.lightGray),
            cornerRadius = cornerRadius(8.0F),
            items = listOf(
                text(
                    text = "-",
                    backgroundColor = color(Color.lightGray),
                    padding = edgeInsets(
                        left = 12,
                        right = 8,
                        top = 4,
                        bottom = 4
                    ),
                    width = wrapContentSize(),
                    fontSize = 18,
                    action = action(
                        actionId = "decreaseButtonAction",
                        action = ChangeIntegerStateAction(
                            variableName = "cartItemCounter-${renderContext.id}",
                            newValue = -1,
                            type = fromExisting
                        )
                    )
                ),
                text(
                    // text = "1",
                    textVariable = TextVariable(
                        name = "cartItemCounter-${renderContext.id}",
                        type = integer(renderContext.count)
                    ),
                    backgroundColor = color(Color.lightGray),
                    width = matchParentSize(),
                    padding = edgeInsets(
                        left = 4,
                        right = 8,
                        top = 4,
                        bottom = 4
                    ),
                ),
                text(
                    text = "+",
                    backgroundColor = color(Color.lightGray),
                    width = wrapContentSize(),
                    padding = edgeInsets(
                        left = 8,
                        right = 12,
                        top = 4,
                        bottom = 4
                    ),
                    fontSize = 18,
                    action = action(
                        actionId = "increaseButtonAction",
                        action = ChangeIntegerStateAction(
                            variableName = "cartItemCounter-${renderContext.id}",
                            newValue = 1,
                            type = fromExisting
                        )
                    )
                )
            )
        )
    }
}
