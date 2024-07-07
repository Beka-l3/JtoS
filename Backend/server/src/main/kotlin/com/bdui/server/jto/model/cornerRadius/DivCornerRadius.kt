package com.bdui.server.jto.model.cornerRadius

import com.bdui.server.jto.UiNamespace
import com.fasterxml.jackson.annotation.JsonUnwrapped

class DivCornerRadius internal constructor(
    @JsonUnwrapped
    val properties: Properties
){
    class Properties internal constructor(
        val topLeading: Float?,
        val topTrailing: Float?,
        val bottomLeading: Float?,
        val bottomTrailing: Float?
    )
}

fun UiNamespace.cornerRadius(
    topLeading: Float = 0.0F,
    topTrailing: Float = 0.0F,
    bottomLeading: Float = 0.0F,
    bottomTrailing: Float = 0.0F
): DivCornerRadius = DivCornerRadius(
    DivCornerRadius.Properties(
        topLeading = topLeading,
        topTrailing = topTrailing,
        bottomLeading = bottomLeading,
        bottomTrailing = bottomTrailing,
    )
)

fun UiNamespace.cornerRadius(
    radius: Float = 0.0F,
): DivCornerRadius = DivCornerRadius(
    DivCornerRadius.Properties(
        topLeading = radius,
        topTrailing = radius,
        bottomLeading = radius,
        bottomTrailing = radius,
    )
)