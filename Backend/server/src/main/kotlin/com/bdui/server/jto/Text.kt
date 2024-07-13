package com.bdui.server.jto

import ColorRGB
import color
import com.bdui.server.jto.model.HorizontalAlignment
import com.bdui.server.jto.model.center
import com.bdui.server.jto.model.insets.EdgeInsets
import com.bdui.server.jto.model.insets.edgeInsets
import com.bdui.server.jto.model.size.Size
import com.bdui.server.jto.model.size.matchParentSize
import com.bdui.server.jto.model.size.wrapContentSize
import com.fasterxml.jackson.annotation.JsonUnwrapped
import java.awt.Color
import java.util.UUID

class Text internal constructor(
    @JsonUnwrapped
    val properties: Properties
) : Div {
    override val type: String
        get() = "text"
    override val id: String
        get() = UUID.randomUUID().toString()
    class Properties internal constructor(
        val text: String,
        val width: Size,
        val height: Size,
        val padding: EdgeInsets,
        val fontSize: Int,
        val horizontalAlignment: HorizontalAlignment,
        val backgroundColor: ColorRGB,
        val action: Action?
    )
}

fun UiNamespace.text(
    text: String,
    width: Size = wrapContentSize(),
    height: Size = wrapContentSize(),
    padding: EdgeInsets = edgeInsets(),
    horizontalAlignment: HorizontalAlignment = center,
    backgroundColor: ColorRGB = color(Color.white),
    fontSize: Int = 14,
    action: Action? = null
): Text = Text(
    Text.Properties(
        text = text,
        width = width,
        height = height,
        padding = padding,
        horizontalAlignment = horizontalAlignment,
        backgroundColor = backgroundColor,
        fontSize = fontSize,
        action = action
    )
)

fun UiNamespace.spacer(): Text = Text(
    Text.Properties(
        text = "",
        width = matchParentSize(),
        height = wrapContentSize(),
        padding = edgeInsets(),
        fontSize = 1,
        backgroundColor = color(Color.white),
        horizontalAlignment = center,
        action = null
    )
)
