//
//  PXPaymentsInfoGeneralEvents.swift
//  MercadoPagoSDKV4
//

import Foundation

enum PXPaymentsInfoGeneralEvents: TrackingEvents {
    case infoGeneral_Follow_Payments([String: Any])
    case infoGeneral_Follow_Confirm_Payments([String: Any])

    var name: String {
        switch self {
        case .infoGeneral_Follow_Payments: return "/px_checkout/follow/payments"
        case .infoGeneral_Follow_Confirm_Payments: return "/px_checkout/follow/confirm_payments"
        }
    }

    var properties: [String: Any] {
        switch self {
        case .infoGeneral_Follow_Payments(let properties), .infoGeneral_Follow_Confirm_Payments(let properties): return properties
        }
    }

    var needsExternalData: Bool {
        switch self {
        case .infoGeneral_Follow_Payments, .infoGeneral_Follow_Confirm_Payments:
            return false
        }
    }
}
