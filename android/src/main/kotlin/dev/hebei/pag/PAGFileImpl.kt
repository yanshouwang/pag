package dev.hebei.pag

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterAssets
import org.libpag.PAGFile

class PAGFileImpl(
    registrar: PAGApiPigeonProxyApiRegistrar, private val context: Context, private val assets: FlutterAssets
) : PigeonApiPAGFileApi(registrar) {
    override fun asset(assetName: String): PAGFile {
        val manager = context.assets
        val key = assets.getAssetFilePathByName(assetName)
        return PAGFile.Load(manager, key)
    }

    override fun file(filePath: String): PAGFile {
        return PAGFile.Load(filePath)
    }

    override fun memory(bytes: ByteArray): PAGFile {
        return PAGFile.Load(bytes)
    }
}