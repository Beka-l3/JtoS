package com.bdui.server.jto.model.Variable

import com.bdui.server.jto.model.BooleanEnumValue
import com.bdui.server.jto.model.EnumValue
import com.bdui.server.jto.model.IntegerEnumValue
import com.bdui.server.jto.model.VariableType
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.JsonSerializer
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.annotation.JsonSerialize

class TextVariable (
    val name: String,
    @JsonSerialize(using = VariableTypeSerializer::class)
    val type: VariableType
)

class VariableTypeSerializer : JsonSerializer<VariableType>() {
    override fun serialize(value: VariableType, gen: JsonGenerator, serializers: SerializerProvider) {
        gen.writeStartObject()
        gen.writeStringField("type", (value as EnumValue).serialized)
        when (value) {
            is IntegerEnumValue -> gen.writeNumberField("defaultValue", value.defaultValue)
            is BooleanEnumValue -> gen.writeBooleanField("defaultValue", value.defaultValue)
            else -> null
        }
        gen.writeEndObject()
    }
}
