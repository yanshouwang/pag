package dev.hebei.pag

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterAssets
import io.flutter.plugin.common.BinaryMessenger

class PAGRegistrarImpl(
    binaryMessenger: BinaryMessenger, private val context: Context, private val assets: FlutterAssets
) : PAGApiPigeonProxyApiRegistrar(binaryMessenger) {
    override fun getPigeonApiPAGViewApi(): PigeonApiPAGViewApi {
        return PAGViewImpl(this, context)
    }

    override fun getPigeonApiPAGCompositionApi(): PigeonApiPAGCompositionApi {
        return PAGCompositionImpl(this)
    }

    override fun getPigeonApiPAGFileApi(): PigeonApiPAGFileApi {
        return PAGFileImpl(this, context, assets)
    }
}