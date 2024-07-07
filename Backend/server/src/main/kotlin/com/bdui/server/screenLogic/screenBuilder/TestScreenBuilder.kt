package com.bdui.server.screenLogic.screenBuilder

import com.bdui.server.bdui.businessLogic.screen
import com.bdui.server.bdui.core.abstract.AbstractScreenBuilder
import com.bdui.server.screenLogic.api.TestStubResolver
import com.bdui.server.screenLogic.sections.cartAddress.TestSection
import com.bdui.server.screenLogic.sections.cartControls.CartControlsSection
import com.bdui.server.screenLogic.sections.cartItems.CartItemsSection
import com.bdui.server.screenLogic.sections.cartTitle.CartTitleSection

class TestScreenBuilder: AbstractScreenBuilder() {
    override fun build() = screen {
        sections {
            section<TestSection> {
                id = "${TestSection.NAME}-1"
                resolver = TestStubResolver()
                assemblerType = "TestAssembler"
            }
            section<CartTitleSection> {
                id = "${CartTitleSection.NAME}-1"
                resolver = TestStubResolver()
                assemblerType = "CartTitleAssembler"
            }
            section<CartControlsSection> {
                id = "${CartControlsSection.NAME}-1"
                resolver = TestStubResolver()
                assemblerType = "CartControlsAssembler"
            }
            section<CartItemsSection> {
                id = "${CartItemsSection.NAME}-1"
                resolver = TestStubResolver()
                assemblerType = "CartItemsAssembler"
            }
        }
    }
}
