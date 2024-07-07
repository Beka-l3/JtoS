package com.bdui.server.jto.model

import com.bdui.server.jto.UiNamespace

sealed interface HorizontalAlignment

object LeftEnumValue: EnumValue("left"), HorizontalAlignment

object CenterEnumValue: EnumValue("center"), HorizontalAlignment, VerticalAlignment

object RightEnumValue: EnumValue("right"), HorizontalAlignment

val UiNamespace.left: LeftEnumValue
    get() = LeftEnumValue

val UiNamespace.center: CenterEnumValue
    get() = CenterEnumValue

val UiNamespace.right: RightEnumValue
    get() = RightEnumValue