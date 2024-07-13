package com.bdui.server.screenLogic.api

import kotlinx.coroutines.Deferred
import kotlinx.coroutines.async
import kotlinx.coroutines.coroutineScope
import com.bdui.server.bdui.core.resolver.Resolver
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import org.springframework.web.client.RestTemplate

class RealBackendResolver: Resolver() {
    override suspend fun resolve(): Deferred<Any?> = coroutineScope {
        async {
            val restTemplate = RestTemplate()
            val url = "http://127.0.0.1:5000/getItems"
            restTemplate.getForObject(url, CartResponse::class.java)
            // val mapper = jacksonObjectMapper()
            // val cartResponse = mapper.readValue<CartResponse>(result)
            // cartResponse
        }
    }
}