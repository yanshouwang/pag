package dev.hebei.pag

import org.libpag.PAGComposition

class PAGCompositionImpl(registrar: PAGApiPigeonProxyApiRegistrar) : PigeonApiPAGCompositionApi(registrar) {
    override fun width(pigeon_instance: PAGComposition): Long {
        return pigeon_instance.width().api
    }

    override fun height(pigeon_instance: PAGComposition): Long {
        return pigeon_instance.height().api
    }
}