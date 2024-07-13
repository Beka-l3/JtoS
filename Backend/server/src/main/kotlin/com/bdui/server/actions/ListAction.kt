package com.bdui.server.actions

import com.bdui.server.bdui.core.abstract.AbstractAction
import com.bdui.server.jto.Action

class ListAction(
    val actions: List<Action>
): AbstractAction()