package com.bdui.server.bdui.engine

import com.bdui.server.bdui.core.model.ScreenRequest
import com.bdui.server.bdui.core.model.ScreenResponse
import org.springframework.context.annotation.Primary
import org.springframework.stereotype.Service
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.runBlocking
import com.bdui.server.bdui.core.abstract.AbstractAssembler
import com.bdui.server.bdui.core.abstract.AbstractSection

@Service
@Primary
class ScreenResourceService(
    private val resolverCaller: ScreenResolverCaller,
    private val assemblerContext: AssemblerContext,
) {
    fun get(
        request: ScreenRequest
    ): ScreenResponse {
        val screenTemplate = request.buildScreenTemplate()
        val sections = runBlocking {
             screenTemplate.sections.map { section ->
                async {
                    section.resolverRespone = resolverCaller.callResolver(section.resolver)
                    val assembler = findAssembler(section)
                    section.snippets = assembler.convert(section)
                    return@async section
                }
            }.awaitAll()
        }
        return ScreenResponse(ui = sections)
    }

    @Throws(IllegalArgumentException::class)
    private fun findAssembler(section: AbstractSection): AbstractAssembler {
        val assemblerType = section.assemblerType ?: throw
            IllegalArgumentException("Assembler for section ${section.assemblerType} has no type")
        return assemblerContext.get(assemblerType) ?:
            throw IllegalArgumentException("Assembler for section ${section.assemblerType} not found")
    }
}