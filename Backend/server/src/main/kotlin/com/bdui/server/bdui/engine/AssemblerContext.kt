package com.bdui.server.bdui.engine

import com.bdui.server.bdui.core.abstract.AbstractAssembler
import com.bdui.server.screenLogic.sections.cartAddress.TestAssembler
import com.bdui.server.screenLogic.sections.cartControls.CartControlsAssembler
import com.bdui.server.screenLogic.sections.cartItems.CartItemsAssembler
import com.bdui.server.screenLogic.sections.cartTitle.CartTitleAssembler
import org.springframework.stereotype.Service
import java.util.stream.Collectors

@Service
class AssemblerContext(
    assemblers: List<AbstractAssembler> = listOf(
        TestAssembler(),
        CartTitleAssembler(),
        CartControlsAssembler(),
        CartItemsAssembler()
    )
) {
    private val assemblersMap = assemblers.stream()
        .collect(
            Collectors.toMap(
                { it.getName() },
                { it },
                { x, _ -> x}
            )
        )

    fun get(name: String): AbstractAssembler? {
        return assemblersMap[name]
    }
}