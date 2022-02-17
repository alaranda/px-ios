//
//  ImpletationStrategyScreen.swift
//  MercadoPagoSDKV4
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 17/02/22.
//

import Foundation

class ImpletationStrategyScreen: StrategyTrackings {
    var flow_name: String?

    required init(flow_name: String) {
        self.flow_name = flow_name
        print("setando todoas as proprieades de uma tela \(flow_name)")
    }

func getPropertiesTrackings(deviceName: String?, connectionType: String?, accessType: String?, versionLib: String?, accessLocation: String?, counter: Int?, paymentMethod: PXPaymentMethod?, offlinePaymentMethod: PXOfflinePaymentMethod?) -> [String: Any] {
        var properties: [String: Any] = [:]
        properties["current_step"] = self.flow_name
        properties["device_name"] = "10.4.5"
        properties["version_lib"] = "4.5.4"
        properties["access_location"] = "pt-Br"
        return properties
    }
}
