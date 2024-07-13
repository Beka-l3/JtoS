package com.bdui.server.jto.model.Variable

import com.bdui.server.jto.model.Url
import com.bdui.server.jto.model.VariableType
import com.fasterxml.jackson.databind.annotation.JsonSerialize

class ImageVariable (
    val name: String,
    val falseState: String,
    val trueState: String,
    @JsonSerialize(using = VariableTypeSerializer::class)
    val type: VariableType,
)
