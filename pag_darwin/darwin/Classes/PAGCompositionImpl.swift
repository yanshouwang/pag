//
//  PAGCompositionImpl.swift
//
//  Created by 闫守旺 on 2025/4/9.
//

import libpag

class PAGCompositionImpl: PigeonApiDelegatePAGCompositionApi {
    func getWidth(pigeonApi: PigeonApiPAGCompositionApi, pigeonInstance: PAGComposition) throws -> Int64 {
        return pigeonInstance.width().api
    }
    
    func getHeight(pigeonApi: PigeonApiPAGCompositionApi, pigeonInstance: PAGComposition) throws -> Int64 {
        return pigeonInstance.height().api
    }
}
