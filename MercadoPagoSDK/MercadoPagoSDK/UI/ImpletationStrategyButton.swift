//
//  ImpletationStrategyButton.swift
//  MercadoPagoSDKV4
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 17/02/22.
//

import Foundation

class ImpletationStrategyButton: StrategyTrackings {
    var flow_name: String?

    required init(flow_name: String) {
        self.flow_name = flow_name
        print("setando todoas as proprieades de um botão \(flow_name)")
    }

    func getPropertiesTrackings(deviceName: String?, connectionType: String?, accessType: String?, versionLib: String?, accessLocation: String?, counter: Int?, paymentMethod: PXPaymentMethod?, offlinePaymentMethod: PXOfflinePaymentMethod?) -> [String: Any] {
        var properties: [String: Any] = [:]
        properties["current_step"] = self.flow_name
        properties["device_name"] = deviceName
        properties["version_lib"] = versionLib
        properties["access_location"] = accessLocation
        properties["counter_pressed_button"] = counter

        if let paymentMethod = paymentMethod {
            properties["payment_status"] = paymentMethod.status
            properties["payment_method_id"] = paymentMethod.id
        }

        if let offlinePaymentMethod = offlinePaymentMethod {
            properties["payment_status"] = offlinePaymentMethod.status
            properties["payment_method_id"] = offlinePaymentMethod.id
        }

        return properties
    }
}
