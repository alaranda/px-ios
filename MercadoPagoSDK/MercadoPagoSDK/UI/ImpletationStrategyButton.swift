//
//  ImpletationStrategyButton.swift
//  MercadoPagoSDKV4
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 17/02/22.
//

import Foundation

enum typeEvent: String {
    case screnn
    case button
}

class ImpletationStrategyButton: StrategyTrackings {
    var flow_name: String?

    required init(flow_name: String) {
        self.flow_name = flow_name
        print("setando todoas as proprieades de um botão \(flow_name)")
    }

    func getPropertiesTrackings(typeEvent: typeEvent = .screnn, deviceName: String?, versionLib: String?, counter: Int?, paymentMethod: PXPaymentMethod?, offlinePaymentMethod: PXOfflinePaymentMethod?, businessResult: PaymentResult?) -> [String: Any] {
        var properties: [String: Any] = [:]

        properties["current_step"] = self.flow_name
        properties["device_name"] = deviceName
        properties["version_lib"] = versionLib
        properties["button_count_pressed"] = counter
        properties["type_event"] = typeEvent

        if let paymentMethod = paymentMethod {
            properties["payment_status"] = paymentMethod.status
            properties["payment_method_id"] = paymentMethod.name
        }

        if let offlinePaymentMethod = offlinePaymentMethod {
            properties["payment_status"] = offlinePaymentMethod.status
            properties["payment_method_id"] = offlinePaymentMethod.name
        }

        if let businessResult = businessResult {
            properties["payment_status"] = businessResult.status
            properties["payment_status_detail"] = businessResult.statusDetail
            properties["payment_method_id"] = businessResult.paymentMethodId
        }

        return properties
    }
}
