package com.bdui.server.jto

import com.bdui.server.jto.model.ContentMode
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
        val fontSize: Int
    )
}

fun UiNamespace.text(
    text: String,
    width: Size = wrapContentSize(),
    height: Size = wrapContentSize(),
    padding: EdgeInsets = edgeInsets(),
    fontSize: Int = 14
): Text = Text(
    Text.Properties(
        text = text,
        width = width,
        height = height,
        padding = padding,
        fontSize = fontSize
    )
)

fun UiNamespace.spacer(): Text = Text(
    Text.Properties(
        text = "",
        width = matchParentSize(),
        height = wrapContentSize(),
        padding = edgeInsets(),
        fontSize = 1
    )
)