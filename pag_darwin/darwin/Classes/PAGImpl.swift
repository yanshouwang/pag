//
//  PAGImpl.swift
//
//  Created by 闫守旺 on 2025/4/9.
//

#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif
import Foundation
import libpag

class PAGImpl: PAGApiPigeonProxyApiRegistrar {
    init(messenger: FlutterBinaryMessenger) {
        let delegate = PAGDelegate()
        super.init(binaryMessenger: messenger, apiDelegate: delegate)
    }
}

class PAGDelegate: PAGApiPigeonProxyApiDelegate {
    func pigeonApiPAGViewApi(_ registrar: PAGApiPigeonProxyApiRegistrar) -> PigeonApiPAGViewApi {
        let impl = PAGViewImpl()
        return PigeonApiPAGViewApi(pigeonRegistrar: registrar, delegate: impl)
    }
    
    func pigeonApiPAGCompositionApi(_ registrar: PAGApiPigeonProxyApiRegistrar) -> PigeonApiPAGCompositionApi {
        let impl = PAGCompositionImpl()
        return PigeonApiPAGCompositionApi(pigeonRegistrar: registrar, delegate: impl)
    }
    
    func pigeonApiPAGFileApi(_ registrar: PAGApiPigeonProxyApiRegistrar) -> PigeonApiPAGFileApi {
        let impl = PAGFileImpl()
        return PigeonApiPAGFileApi(pigeonRegistrar: registrar, delegate: impl)
    }
}
