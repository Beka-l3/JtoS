package com.bdui.server.screenLogic.controller

import com.bdui.server.bdui.core.abstract.AbstractPatchController
import com.bdui.server.bdui.core.model.ScreenRequest
import com.bdui.server.bdui.core.model.ScreenResponse
import com.bdui.server.screenLogic.api.CartResponse
import com.bdui.server.screenLogic.api.PatchRequestBody
import com.bdui.server.screenLogic.api.realBackend.RealBackendClient
import com.bdui.server.screenLogic.api.realBackend.RealBackendPatchType
import com.bdui.server.screenLogic.api.realBackend.RealBackendResolver
import com.bdui.server.screenLogic.implementation.DefaultScreenProcessor
import com.bdui.server.screenLogic.screenBuilder.TestScreenBuilder
import kotlinx.coroutines.runBlocking
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@Service
@RestController
class TestPatchController(
    private val screenProcessor: DefaultScreenProcessor,
    private val realBackendClient: RealBackendClient
) : AbstractPatchController() {

    @PostMapping("/cart/increasePatch")
    fun increasePatch(
        @RequestBody body: PatchRequestBody
    ):  ResponseEntity<ScreenResponse> {
        val patchData = RealBackendPatchType.ChangeCounterPatch(
            targetId = body.target,
            newValue = body.state[body.target] ?: return createFallback()
        ).patchData()

        val response = runBlocking {
            realBackendClient.sendPatch( patchData = patchData)
        } ?: return createFallback()

        return ResponseEntity(createScreenResponse(response = response), HttpStatus.OK)
    }

    private fun createScreenResponse(response: CartResponse): ScreenResponse {
        val request = ScreenRequest()
        request.screenBuilder = TestScreenBuilder()
        request.preResolvedResponses = mapOf(
            RealBackendResolver.javaClass.name to response
        )
        return screenProcessor.getScreen(request = request)
    }

    private fun createFallback(): ResponseEntity<ScreenResponse> {
        return ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR)
    }
}