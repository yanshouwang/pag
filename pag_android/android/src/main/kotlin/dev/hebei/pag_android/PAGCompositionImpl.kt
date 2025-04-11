package dev.hebei.pag_android

import org.libpag.PAGComposition

class PAGCompositionImpl(registrar: PAGApiPigeonProxyApiRegistrar) : PigeonApiPAGCompositionApi(registrar) {
    override fun getWidth(pigeon_instance: PAGComposition): Long {
        return pigeon_instance.width().api
    }

    override fun getHeight(pigeon_instance: PAGComposition): Long {
        return pigeon_instance.height().api
    }
}