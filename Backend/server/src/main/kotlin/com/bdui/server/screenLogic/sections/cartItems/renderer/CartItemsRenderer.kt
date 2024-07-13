package com.bdui.server.screenLogic.sections.cartItems.renderer

import color
import com.bdui.server.actions.ChangeBooleanStateAction
import com.bdui.server.actions.ChangeIntegerStateAction
import com.bdui.server.actions.ListAction
import com.bdui.server.actions.PatchAction
import com.bdui.server.jto.Div
import com.bdui.server.jto.UiNamespace
import com.bdui.server.jto.View
import com.bdui.server.jto.action
import com.bdui.server.jto.container
import com.bdui.server.jto.image
import com.bdui.server.jto.model.Variable.ImageVariable
import com.bdui.server.jto.model.Variable.TextVariable
import com.bdui.server.jto.model.boolean
import com.bdui.server.jto.model.cornerRadius.cornerRadius
import com.bdui.server.jto.model.fit
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

    private fun UiNamespace.renderImage(url: String): Div {
        return image(
            url(url = url),
            width = fixedSize(96),
            height = fixedSize(96)
        )
    }

    private fun UiNamespace.renderItemInfoContainer(renderContext: CartItemRenderContext): Div {
        return container(
            width = matchParentSize(),
            height = matchParentSize(),
            orientation = vertical,
            verticalAlignment = top,
            padding = edgeInsets(left = 12),
            items = listOf(
                renderTextAndCheckedButton(renderContext = renderContext),
                text(
                    text = renderContext.shopName,
                    textColor = color(Color.gray),
                    width = matchParentSize(),
                    horizontalAlignment = left,
                    padding = edgeInsets(top = 12)
                ),
                renderPriceContainer(renderContext.price),
                renderControls(renderContext)
            )
        )
    }

    private fun UiNamespace.renderTextAndCheckedButton(renderContext: CartItemRenderContext): Div {
        return container(
            width = matchParentSize(),
            height = wrapContentSize(),
            orientation = horizontal,
            verticalAlignment = top,
            items = listOf(
                text(
                    text = renderContext.name,
                    isBold = true,
                    width = matchParentSize(),
                    horizontalAlignment = left
                ),
                image(
                    imageVariable = ImageVariable(
                        name = "cartItem-isChecked-${renderContext.id}",
                        type = boolean(renderContext.isSelected),
                        falseState = "https://i.ibb.co/r5zZGSq/unchecked.png",
                        trueState = "https://i.ibb.co/GvcpNWf/Shape-Square-Size-Large-Hovered-No-Checked-Yes-Focused-No-Disabled-No-Indeterminate-No.png"
                    ),
                    width = fixedSize(24),
                    height = fixedSize(24),
                    contentMode = fit,
                    action = action(
                        actionId = "isCheckedButtonListAction",
                        action = ListAction(
                            actions = listOf(
                                action(
                                    actionId = "changeBooleanStateActionId",
                                    action = ChangeBooleanStateAction(
                                        variableName = "cartItem-isChecked-${renderContext.id}"
                                    )
                                ),
                                action(
                                    actionId = "decreaseButtonPatchAction",
                                    action = PatchAction(
                                        path = "cart/changeIsSelectedPatch",
                                        target = "${renderContext.id}"
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    }

    private fun UiNamespace.renderPriceContainer(price: Double): Div {
        return container(
            width = matchParentSize(),
            height = wrapContentSize(),
            orientation = vertical,
            padding = edgeInsets(top = 12),
            items = listOf(
                text(
                    text = "$price руб",
                    isBold = true,
                    width = matchParentSize(),
                    horizontalAlignment = left,
                    padding = edgeInsets(top = 2),
                    fontSize = 18
                )
            )
        )
    }

    private fun UiNamespace.renderControls(renderContext: CartItemRenderContext): Div {
        return container(
            width = matchParentSize(),
            height = wrapContentSize(),
            orientation = horizontal,
            padding = edgeInsets(top = 12),
            items = listOf(
                text(
                    isBold = true,
                    textColor = color(Color.gray),
                    fontSize = 14,
                    text = "Delete",
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
            backgroundColor = color(Color(242, 242, 242)),
            cornerRadius = cornerRadius(8.0F),
            items = listOf(
                text(
                    text = "-",
                    backgroundColor = color(Color(242, 242, 242)),
                    padding = edgeInsets(
                        left = 12,
                        right = 8,
                        top = 4,
                        bottom = 4
                    ),
                    width = wrapContentSize(),
                    fontSize = 18,
                    action = action(
                        actionId = "decreaseButtonListAction",
                        action = ListAction(
                            actions = listOf(
                                action(
                                    actionId = "decreaseButtonAction",
                                    action = ChangeIntegerStateAction(
                                        variableName = "${renderContext.id}",
                                        newValue = -1,
                                        type = fromExisting
                                    )
                                ),
                                action(
                                    actionId = "decreaseButtonPatchAction",
                                    action = PatchAction(
                                        path = "cart/changeCountPatch",
                                        target = "${renderContext.id}"
                                    )
                                )
                            )
                        )
                    )
                ),
                text(
                    textVariable = TextVariable(
                        name = "${renderContext.id}",
                        type = integer(renderContext.count)
                    ),
                    backgroundColor = color(Color(242, 242, 242)),
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
                    backgroundColor = color(Color(242, 242, 242)),
                    width = wrapContentSize(),
                    padding = edgeInsets(
                        left = 8,
                        right = 12,
                        top = 4,
                        bottom = 4
                    ),
                    fontSize = 18,
                    action = action(
                        actionId = "increaseButtonListAction",
                        action = ListAction(
                            actions = listOf(
                                action(
                                    actionId = "increaseButtonAction",
                                    action = ChangeIntegerStateAction(
                                        variableName = "${renderContext.id}",
                                        newValue = 1,
                                        type = fromExisting
                                    )
                                ),
                                action(
                                    actionId = "increaseButtonPatchAction",
                                    action = PatchAction(
                                        path = "cart/changeCountPatch",
                                        target = "${renderContext.id}"
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    }
}
