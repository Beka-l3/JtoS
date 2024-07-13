package com.bdui.server.bdui.core.model

import com.bdui.server.bdui.core.abstract.AbstractScreenBuilder

class ScreenRequest (
    val screenId: String? = null,
    var screenBuilder: AbstractScreenBuilder? = null,
    var preResolvedResponses: Map<String, Any>? = null
)