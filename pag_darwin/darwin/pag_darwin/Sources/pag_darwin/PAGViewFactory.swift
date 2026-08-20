//
//  PAGViewFactory.swift
//
//  Created by 闫守旺 on 2025/4/9.
//

#if os(iOS)
import Flutter
import UIKit
#elseif os(macOS)
import FlutterMacOS
import Cocoa
#else
#error("Unsupported platform.")
#endif

class PAGViewFactory: NSObject, FlutterPlatformViewFactory {
    unowned let instanceManager: PAGApiPigeonInstanceManager
    
    init(instanceManager: PAGApiPigeonInstanceManager) {
        self.instanceManager = instanceManager
    }
#if os(iOS)
    class PAGViewImpl: NSObject, FlutterPlatformView {
        let obj: UIView
        
        init(view obj: UIView, frame: CGRect) {
            obj.frame = frame
            self.obj = obj
        }
        
        func view() -> UIView {
            return obj
        }
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> any FlutterPlatformView {
        let identifier = args is Int64 ? args as! Int64 : Int64(args as! Int32)
        let instance = instanceManager.instance(forIdentifier: identifier) as AnyObject?
        if let impl = instance as? PAGViewImpl {
            return impl
        } else {
            let view = instance as! UIView
            return PAGViewImpl(view: view, frame: frame)
        }
    }
    
    func createArgsCodec() -> any FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
#elseif os(macOS)
    func create(withViewIdentifier viewId: Int64, arguments args: Any?) -> NSView {
        let identifier = args is Int64 ? args as! Int64 : Int64(args as! Int32)
        let view = instanceManager.instance(forIdentifier: identifier) as NSView?
        return view!
    }
    
    func createArgsCodec() -> (any FlutterMessageCodec & NSObjectProtocol)? {
        return FlutterStandardMessageCodec.sharedInstance()
    }
#endif
}
