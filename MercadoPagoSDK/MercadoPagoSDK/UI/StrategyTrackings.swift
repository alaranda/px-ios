//
//  StrategyTrackings.swift
//  MercadoPagoSDKV4
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 17/02/22.
//

import Foundation

protocol StrategyTrackings {
    func getPropertiesTrackings(deviceName: String?, connectionType: String?, accessType: String?, versionLib: String?, accessLocation: String?, counter: Int?, paymentMethod: PXPaymentMethod?, offlinePaymentMethod: PXOfflinePaymentMethod?) -> [String: Any]

    init(flow_name: String)
}
