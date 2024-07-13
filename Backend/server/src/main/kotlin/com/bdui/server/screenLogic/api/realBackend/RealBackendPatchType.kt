package com.bdui.server.screenLogic.api.realBackend

sealed class RealBackendPatchType {
    data class ChangeCounterPatch(
        val targetId: String,
        val newValue: String
    ): RealBackendPatchType() {
        fun patchData() : Map<String, String> {
            return mapOf(
                "patchType" to "ChangeCounterPatch",
                "targetId" to targetId,
                "newValue" to newValue
            )
        }
    }
}
