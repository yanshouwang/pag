package dev.zeekr.pag_android

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterAssets
import org.libpag.PAGFile

class PAGFileImpl(
    registrar: PAGApiPigeonProxyApiRegistrar,
    private val context: Context,
    private val assets: FlutterAssets
) : PigeonApiPAGFileApi(registrar) {
    override fun asset(asset: String): PAGFile {
        val manager = context.assets
        val key = assets.getAssetFilePathByName(asset)
        return PAGFile.Load(manager, key)
    }

    override fun file(file: String): PAGFile {
        return PAGFile.Load(file)
    }

    override fun bytes(bytes: ByteArray): PAGFile {
        return PAGFile.Load(bytes)
    }
}