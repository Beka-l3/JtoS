package com.bdui.server.jto.model

import com.bdui.server.jto.UiNamespace
import com.fasterxml.jackson.annotation.JsonInclude

sealed interface VariableType

data class IntegerEnumValue(
    @JsonInclude
    val defaultValue: Int
): EnumValue("Integer"), VariableType

fun UiNamespace.integer(defaultValue: Int): IntegerEnumValue {
    return IntegerEnumValue(defaultValue)
}

data class BooleanEnumValue(
    @JsonInclude
    val defaultValue: Boolean
): EnumValue("Boolean"), VariableType

fun UiNamespace.boolean(defaultValue: Boolean): BooleanEnumValue {
    return BooleanEnumValue(defaultValue)
}