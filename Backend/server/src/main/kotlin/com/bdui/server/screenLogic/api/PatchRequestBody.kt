package com.bdui.server.screenLogic.api

import java.util.Dictionary

data class PatchRequestBody(
    val target: String,
    val state: Map<String, String>
)