package com.bdui.server.actions

import com.bdui.server.bdui.core.abstract.AbstractAction
import com.bdui.server.jto.model.IntegerStateChangeType

class ChangeIntegerStateAction(
    val variableName: String,
    val newValue: Int,
    val type: IntegerStateChangeType
) : AbstractAction()