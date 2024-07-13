package com.bdui.server.actions

import com.bdui.server.bdui.core.abstract.AbstractAction
import com.fasterxml.jackson.annotation.JsonInclude

class PatchAction(
    val path: String,
    val target: String
): AbstractAction()