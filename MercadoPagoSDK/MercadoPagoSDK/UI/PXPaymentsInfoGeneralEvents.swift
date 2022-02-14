//
//  PXPaymentsInfoGeneralEvents.swift
//  MercadoPagoSDKV4
//

import Foundation

enum PXPaymentsInfoGeneralEvents: TrackingEvents {
    case infoGeneral_Follow
    case infoGeneral_Follow_Payments(String, [String: Any])
    case infoGeneral_Follow_Confirm_Payments(String, [String: Any])

    var name: String {
        switch self {
        case .infoGeneral_Follow: return "/px_checkout/follow"
        case .infoGeneral_Follow_Payments(let screenFlow, _): return "/px_checkout/follow/payments/\(screenFlow)"
        case .infoGeneral_Follow_Confirm_Payments(let screenFlow, _): return "/px_checkout/follow/confirm_payments/\(screenFlow)"
        }
    }

    var properties: [String: Any] {
        switch self {
        case .infoGeneral_Follow: return [:]
        case .infoGeneral_Follow_Payments(_, let properties), .infoGeneral_Follow_Confirm_Payments(_, let properties): return properties
        }
    }

    var needsExternalData: Bool {
        switch self {
        case .infoGeneral_Follow:
            return true
        case .infoGeneral_Follow_Payments, .infoGeneral_Follow_Confirm_Payments:
            return false
        }
    }
}
