package com.bdui.server.screenLogic.sections.cartAddress.renderer

import color
import com.bdui.server.jto.View
import com.bdui.server.jto.container
import com.bdui.server.jto.model.cornerRadius.cornerRadius
import com.bdui.server.jto.model.horizontal
import com.bdui.server.jto.model.size.fixedSize
import com.bdui.server.jto.model.size.matchParentSize
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
                        backgroundColor = color(Color.lightGray),
                        items = listOf(
                            container(
                                orientation = horizontal,
                                height = matchParentSize(),
                                cornerRadius = cornerRadius(
                                    bottomLeading = 20.0F,
                                    bottomTrailing = 20.0F
                                ),
                                items = listOf(
                                    text(
                                        text = "SomeText"
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
