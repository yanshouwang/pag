//
//  PAGFileImpl.swift
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
import libpag

class PAGFileImpl: PigeonApiDelegatePAGFileApi {
    func asset(pigeonApi: PigeonApiPAGFileApi, asset: String) throws -> PAGFile {
        let assetKey = FlutterDartProject.lookupKey(forAsset: asset)
#if os(iOS)
        let assetPath = Bundle.main.path(forResource: assetKey, ofType: nil)!
#elseif os(macOS)
        // See https://github.com/flutter/flutter/issues/135302
        let assetPath = URL(string: assetKey, relativeTo: Bundle.main.bundleURL)!.path
#endif
        return PAGFile.load(assetPath)
    }
    
    func file(pigeonApi: PigeonApiPAGFileApi, file: String) throws -> PAGFile {
        return PAGFile.load(file)
    }
    
    func memory(pigeonApi: PigeonApiPAGFileApi, memory: FlutterStandardTypedData) throws -> PAGFile {
        let data = memory.data
        return try! data.withUnsafeBytes<UInt8> {
            return PAGFile.load($0.baseAddress!, size: data.count)
        }
    }
}
