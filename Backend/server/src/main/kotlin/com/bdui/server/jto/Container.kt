package com.bdui.server.jto

import ColorRGB
import color
import com.bdui.server.jto.model.HorizontalAlignment
import com.bdui.server.jto.model.Orientation
import com.bdui.server.jto.model.VerticalAlignment
import com.bdui.server.jto.model.center
import com.bdui.server.jto.model.cornerRadius.DivCornerRadius
import com.bdui.server.jto.model.cornerRadius.cornerRadius
import com.bdui.server.jto.model.insets.EdgeInsets
import com.bdui.server.jto.model.insets.edgeInsets
import com.bdui.server.jto.model.size.Size
import com.bdui.server.jto.model.size.matchParentSize
import com.bdui.server.jto.model.size.wrapContentSize
import com.fasterxml.jackson.annotation.JsonUnwrapped
import java.awt.Color
import java.util.UUID

class Container internal constructor(
    @JsonUnwrapped
    val properties: Properties
): Div {
    override val type: String
        get() = "container"
    override val id: String
        get() = UUID.randomUUID().toString()
    class Properties internal constructor(
        val width: Size,
        val height: Size,
        val padding: EdgeInsets,
        val items: List<Div>,
        val orientation: Orientation,
        val backgroundColor: ColorRGB,
        val cornerRadius: DivCornerRadius,
        val verticalAlignment: VerticalAlignment,
        val horizontalAlignment: HorizontalAlignment
    )
}

fun UiNamespace.container(
    width: Size = matchParentSize(),
    height: Size = wrapContentSize(),
    padding: EdgeInsets = edgeInsets(),
    items: List<Div>,
    orientation: Orientation,
    backgroundColor: ColorRGB = color(Color.white),
    cornerRadius: DivCornerRadius = cornerRadius(0.0F),
    verticalAlignment: VerticalAlignment = center,
    horizontalAlignment: HorizontalAlignment = center
): Container = Container(
    Container.Properties(
        width = width,
        height = height,
        padding = padding,
        items = items,
        orientation = orientation,
        backgroundColor = backgroundColor,
        cornerRadius = cornerRadius,
        verticalAlignment = verticalAlignment,
        horizontalAlignment = horizontalAlignment
    )
)