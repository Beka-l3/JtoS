package com.bdui.server.jto.model

import com.bdui.server.jto.UiNamespace

sealed interface VerticalAlignment

object TopEnumValue: EnumValue("top"), VerticalAlignment

object BottomEnumValue: EnumValue("bottom"), VerticalAlignment

val UiNamespace.top: TopEnumValue
    get() = TopEnumValue

val UiNamespace.bottom: BottomEnumValue
    get() = BottomEnumValue