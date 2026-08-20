//
//  PAGViewImpl.swift
//
//  Created by 闫守旺 on 2025/4/9.
//

import libpag

class PAGViewImpl: PigeonApiDelegatePAGViewApi {
    func pigeonDefaultConstructor(pigeonApi: PigeonApiPAGViewApi) throws -> PAGView {
        return PAGView()
    }
    
    func getComposition(pigeonApi: PigeonApiPAGViewApi, pigeonInstance: PAGView) throws -> PAGComposition {
        return pigeonInstance.getComposition()
    }
    
    func setCompositon(pigeonApi: PigeonApiPAGViewApi, pigeonInstance: PAGView, value: PAGComposition) throws {
        pigeonInstance.setComposition(value)
    }
    
    func getRepeatCount(pigeonApi: PigeonApiPAGViewApi, pigeonInstance: PAGView) throws -> Int64 {
        return pigeonInstance.repeatCount().api
    }
    
    func setRepeatCount(pigeonApi: PigeonApiPAGViewApi, pigeonInstance: PAGView, value: Int64) throws {
        pigeonInstance.setRepeatCount(value.impl)
    }
    
    func getScaleMode(pigeonApi: PigeonApiPAGViewApi, pigeonInstance: PAGView) throws -> PAGScaleModeApi {
        return try pigeonInstance.scaleMode().api
    }
    
    func setScaleMode(pigeonApi: PigeonApiPAGViewApi, pigeonInstance: PAGView, value: PAGScaleModeApi) throws {
        pigeonInstance.setScaleMode(value.impl)
    }
    
    func getProgress(pigeonApi: PigeonApiPAGViewApi, pigeonInstance: PAGView) throws -> Double {
        return pigeonInstance.getProgress()
    }
    
    func setProgress(pigeonApi: PigeonApiPAGViewApi, pigeonInstance: PAGView, value: Double) throws {
        pigeonInstance.setProgress(value)
    }
    
    func isPlaying(pigeonApi: PigeonApiPAGViewApi, pigeonInstance: PAGView) throws -> Bool {
        return pigeonInstance.isPlaying()
    }
    
    func play(pigeonApi: PigeonApiPAGViewApi, pigeonInstance: PAGView) throws {
        pigeonInstance.play()
    }
    
    func pause(pigeonApi: PigeonApiPAGViewApi, pigeonInstance: PAGView) throws {
        pigeonInstance.pause()
    }
    
    func stop(pigeonApi: PigeonApiPAGViewApi, pigeonInstance: PAGView) throws {
        pigeonInstance.stop()
    }
}
