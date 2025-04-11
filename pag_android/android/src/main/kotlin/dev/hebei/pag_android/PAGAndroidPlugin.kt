package dev.hebei.pag_android

import io.flutter.embedding.engine.plugins.FlutterPlugin

/** PAGAndroidPlugin */
class PAGAndroidPlugin : FlutterPlugin {
    private lateinit var impl: PAGImpl

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        impl = PAGImpl(binding.binaryMessenger, binding.applicationContext, binding.flutterAssets)
        impl.setUp()
        val viewFactory = PAGViewFactory(impl.instanceManager)
        binding.platformViewRegistry.registerViewFactory("hebei.dev/PAGView", viewFactory)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        impl.tearDown()
        impl.instanceManager.stopFinalizationListener()
    }
}
