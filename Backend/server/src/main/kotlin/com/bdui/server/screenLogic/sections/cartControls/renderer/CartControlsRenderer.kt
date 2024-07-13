package com.bdui.server.screenLogic.sections.cartControls.renderer

import com.bdui.server.actions.PatchAction
import com.bdui.server.jto.View
import com.bdui.server.jto.action
import com.bdui.server.jto.container
import com.bdui.server.jto.model.horizontal
import com.bdui.server.jto.model.insets.edgeInsets
import com.bdui.server.jto.model.size.matchParentSize
import com.bdui.server.jto.singleState
import com.bdui.server.jto.spacer
import com.bdui.server.jto.text
import com.bdui.server.jto.ui
import com.bdui.server.jto.view
import com.bdui.server.screenLogic.sections.cartControls.context.CartControlsContext
import java.util.UUID

object CartControlsRenderer {

    fun render(renderContext: CartControlsContext): View {
        return ui {
            view(
                id = "cart-title-snippet-id-${UUID.randomUUID()}",
                states = singleState(
                    div = container(
                        orientation = horizontal,
                        padding = edgeInsets(top = 10),
                        items = listOf(
                            text(
                                "Delete chosen",
                                padding = edgeInsets(left = 16)
                            ),
                            spacer(),
                            text(
                                "Choose all",
                                padding = edgeInsets(right = 16),
                                action = action(
                                    actionId = "chooseAllPatchAction",
                                    action = PatchAction(
                                        path = "cart/chooseAllPatch",
                                        target = ""
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