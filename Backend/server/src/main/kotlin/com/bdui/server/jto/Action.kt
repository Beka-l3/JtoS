package com.bdui.server.jto
import com.bdui.server.bdui.core.abstract.AbstractAction
import com.fasterxml.jackson.annotation.JsonUnwrapped

class Action internal constructor(
    @JsonUnwrapped
    val properties: Properties
) {
    class Properties internal constructor(
        val id: String,
        val action: AbstractAction,
    )
}

fun UiNamespace.action(
    actionId: String,
    action: AbstractAction
): Action = Action(
    Action.Properties(
        id = actionId,
        action = action
    )
)
