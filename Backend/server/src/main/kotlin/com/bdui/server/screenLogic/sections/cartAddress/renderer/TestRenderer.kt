package com.bdui.server.screenLogic.sections.cartAddress.renderer

import color
import com.bdui.server.jto.View
import com.bdui.server.jto.container
import com.bdui.server.jto.image
import com.bdui.server.jto.model.Url
import com.bdui.server.jto.model.cornerRadius.cornerRadius
import com.bdui.server.jto.model.horizontal
import com.bdui.server.jto.model.insets.edgeInsets
import com.bdui.server.jto.model.left
import com.bdui.server.jto.model.size.fixedSize
import com.bdui.server.jto.model.size.matchParentSize
import com.bdui.server.jto.model.size.wrapContentSize
import com.bdui.server.jto.model.vertical
import com.bdui.server.jto.singleState
import com.bdui.server.jto.text
import com.bdui.server.jto.ui
import com.bdui.server.jto.view
import com.bdui.server.screenLogic.sections.cartAddress.context.TestRenderContext
import java.awt.Color
import java.util.UUID

object TestRenderer {

    fun render(renderContext: TestRenderContext): View {
        return ui {
            view(
                id = "snippet-id-${UUID.randomUUID()}",
                states = singleState(
                    div = container(
                        orientation = horizontal,
                        height = fixedSize(48),
                        backgroundColor = color(Color(242, 242, 242)),
                        items = listOf(
                            container(
                                orientation = horizontal,
                                height = matchParentSize(),
                                horizontalAlignment = left,
                                cornerRadius = cornerRadius(
                                    bottomLeading = 20.0F,
                                    bottomTrailing = 20.0F
                                ),
                                items = listOf(
                                    image(
                                        padding = edgeInsets(left = 16),
                                        imageUrl = Url("https://i.ibb.co/0cLmLnz/address.png"),
                                        width = fixedSize(24),
                                        height = fixedSize(24)
                                    ),
                                    container(
                                        orientation = vertical,
                                        height = matchParentSize(),
                                        width = matchParentSize(),
                                        horizontalAlignment = left,
                                        padding = edgeInsets(left = 16),
                                        items = listOf(
                                            text(
                                                width = wrapContentSize(),
                                                horizontalAlignment = left,
                                                fontSize = 12,
                                                textColor = color(Color(159, 159, 159)),
                                                text = "Доставка курьером",
                                            ),
                                            text(
                                                width = wrapContentSize(),
                                                isBold = true,
                                                horizontalAlignment = left,
                                                text = "Университетская д.1 к.1",
                                            )
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
}
