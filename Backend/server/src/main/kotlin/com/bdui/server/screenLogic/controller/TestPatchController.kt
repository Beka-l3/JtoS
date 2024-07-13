package com.bdui.server.screenLogic.controller

import com.bdui.server.bdui.core.abstract.AbstractPatchController
import com.bdui.server.bdui.core.model.ScreenRequest
import com.bdui.server.bdui.core.model.ScreenResponse
import com.bdui.server.screenLogic.implementation.DefaultScreenProcessor
import com.bdui.server.screenLogic.screenBuilder.TestScreenBuilder
import org.springframework.stereotype.Service
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RestController

@Service
@RestController
class TestPatchController(
    private val screenProcessor: DefaultScreenProcessor
) : AbstractPatchController() {

    @PostMapping("/cart/increasePatch")
    fun increasePatch(): ScreenResponse {
        val request = ScreenRequest()
        request.screenBuilder = TestScreenBuilder()
        return screenProcessor.getScreen(request = request)
    }
}