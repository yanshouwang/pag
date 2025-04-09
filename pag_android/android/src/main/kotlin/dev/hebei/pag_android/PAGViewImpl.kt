package dev.hebei.pag_android

import android.content.Context
import org.libpag.PAGComposition
import org.libpag.PAGView

class PAGViewImpl(registrar: PAGApiPigeonProxyApiRegistrar, private val context: Context) :
    PigeonApiPAGViewApi(registrar) {
    override fun pigeon_defaultConstructor(): PAGView {
        return PAGView(context)
    }

    override fun getComposition(pigeon_instance: PAGView): PAGComposition {
        return pigeon_instance.composition
    }

    override fun setCompositon(pigeon_instance: PAGView, value: PAGComposition) {
        pigeon_instance.composition = value
    }

    override fun getRepeatCount(pigeon_instance: PAGView): Long {
        return pigeon_instance.repeatCount().api
    }

    override fun setRepeatCount(pigeon_instance: PAGView, value: Long) {
        pigeon_instance.setRepeatCount(value.impl)
    }

    override fun getScaleMode(pigeon_instance: PAGView): PAGScaleModeApi {
        return pigeon_instance.scaleMode().scaleModeApi
    }

    override fun setScaleMode(pigeon_instance: PAGView, value: PAGScaleModeApi) {
        pigeon_instance.setScaleMode(value.impl)
    }

    override fun getProgress(pigeon_instance: PAGView): Double {
        return pigeon_instance.progress
    }

    override fun setProgress(pigeon_instance: PAGView, value: Double) {
        pigeon_instance.progress = value
    }

    override fun isPlaying(pigeon_instance: PAGView): Boolean {
        return pigeon_instance.isPlaying
    }

    override fun play(pigeon_instance: PAGView) {
        pigeon_instance.play()
    }

    override fun pause(pigeon_instance: PAGView) {
        pigeon_instance.pause()
    }

    override fun stop(pigeon_instance: PAGView) {
        pigeon_instance.stop()
    }
}