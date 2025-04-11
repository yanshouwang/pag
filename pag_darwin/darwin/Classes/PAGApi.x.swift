//
//  PAGApi.x.swift
//
//  Created by 闫守旺 on 2025/4/9.
//

import libpag

extension Int {
    var api: Int64 {
        return Int64(self)
    }
}

extension Int32 {
    var api: Int64 {
        return Int64(self)
    }
}

extension Int64 {
    var impl: Int32 {
        return Int32(self)
    }
}

extension PAGScaleMode {
    var api: PAGScaleModeApi {
        get throws {
            switch self {
            case PAGScaleModeNone:
                return .none
            case PAGScaleModeStretch:
                return .stretch
            case PAGScaleModeLetterBox:
                return .letterBox
            case PAGScaleModeZoom:
                return .zoom
            default:
                throw PAGError(code: "PAGError", message: "Illegal arguments \(self)", details: nil)
            }
        }
    }
}

extension PAGScaleModeApi {
    var impl: PAGScaleMode {
        switch self {
        case .none:
            return PAGScaleModeNone
        case .stretch:
            return PAGScaleModeStretch
        case .letterBox:
            return PAGScaleModeLetterBox
        case .zoom:
            return PAGScaleModeZoom
        }
    }
}
