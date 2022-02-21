//
//  StrategyTrackings.swift
//  MercadoPagoSDKV4
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 17/02/22.
//

import Foundation

protocol StrategyTrackings {
    func getPropertiesTrackings(typeEvent: typeEvent, deviceName: String?, versionLib: String?, counter: Int?, paymentMethod: PXPaymentMethod?, offlinePaymentMethod: PXOfflinePaymentMethod?, businessResult: PaymentResult?) -> [String: Any]

    init(flow_name: String)
}
