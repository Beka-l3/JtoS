package com.bdui.server.jto.model

import com.bdui.server.jto.UiNamespace

sealed interface VerticalAlignment

object TopEnumValue: EnumValue("top"), VerticalAlignment

object BottomEnumValue: EnumValue("bottom"), VerticalAlignment

object FirstTextBaseline: EnumValue("firstTextBaseline"), VerticalAlignment
val UiNamespace.top: TopEnumValue
    get() = TopEnumValue

val UiNamespace.bottom: BottomEnumValue
    get() = BottomEnumValue
val UiNamespace.firstTextBaseline: FirstTextBaseline
    get() = FirstTextBaseline
