package dev.hebei.pag

import io.flutter.embedding.engine.plugins.FlutterPlugin

/** PAGPlugin */
class PAGPlugin : FlutterPlugin {
    private lateinit var registrar: PAGApiPigeonProxyApiRegistrar

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        registrar = PAGRegistrarImpl(binding.binaryMessenger, binding.applicationContext, binding.flutterAssets)
        registrar.setUp()
        val viewFactory = ViewFactory(registrar.instanceManager)
        binding.platformViewRegistry.registerViewFactory("hebei.dev/PAGView", viewFactory)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        registrar.tearDown()
        registrar.instanceManager.stopFinalizationListener()
    }
}
