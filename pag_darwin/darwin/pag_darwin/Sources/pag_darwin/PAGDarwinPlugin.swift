#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

public class PAGDarwinPlugin: NSObject, FlutterPlugin {
    var impl: PAGImpl?
    
    init(messenger: FlutterBinaryMessenger) {
        self.impl = PAGImpl(messenger: messenger)
        self.impl!.setUp()
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
#if os(iOS)
        let messenger = registrar.messenger()
#else
        let messenger = registrar.messenger
#endif
        let instance = PAGDarwinPlugin(messenger: messenger)
        let viewFactory = PAGViewFactory(instanceManager: instance.impl!.instanceManager)
        registrar.register(viewFactory, withId: "hebei.dev/PAGView")
        registrar.publish(instance)
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        self.impl!.ignoreCallsToDart = true
        self.impl!.tearDown()
        self.impl = nil
    }
}
