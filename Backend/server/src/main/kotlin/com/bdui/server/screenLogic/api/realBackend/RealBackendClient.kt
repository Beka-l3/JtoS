package com.bdui.server.screenLogic.api.realBackend

import com.bdui.server.screenLogic.api.CartResponse
import org.springframework.stereotype.Service
import org.springframework.http.HttpEntity
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.web.client.RestTemplate

@Service
class RealBackendClient {
    suspend fun sendPatch(patchData: Map<String, String>): CartResponse? {
        val headers = HttpHeaders()
        headers.contentType = MediaType.APPLICATION_JSON
        val request = HttpEntity(patchData, headers)
        val restTemplate = RestTemplate()
        val url = "http://127.0.0.1:5000/patch"
        return restTemplate.postForObject(url, request, CartResponse::class.java)
    }
}

