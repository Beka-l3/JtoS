package com.bdui.server.jto.model

import com.bdui.server.jto.UiNamespace
sealed interface IntegerStateChangeType

object Absolute: EnumValue("absolute"), IntegerStateChangeType

val UiNamespace.absolute: Absolute
    get() = Absolute

object FromExisting: EnumValue("fromExisting"), IntegerStateChangeType
val UiNamespace.fromExisting: FromExisting
    get() = FromExisting
