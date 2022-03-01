//
//  PXAdsBannerEventData.swift
//  MercadoPagoSDKV4
//
//  Created by Alexis Aranda on 28-02-22.
//

import Foundation

@objcMembers
public class PXAdsBannerEventData: NSObject, Codable {
    let audience: String
    let componentId: String
    let contentSource: String
    let printId: String
    let logic: String
    let position: Int
    let flow: Int
    let campaignId: Int

    public init(audience: String, componentId: String, contentSource: String, printId: String, logic: String, position: Int, flow: Int, campaignId: Int) {
        self.audience = audience
        self.componentId = componentId
        self.contentSource = contentSource
        self.printId = printId
        self.logic = logic
        self.position = position
        self.flow = flow
        self.campaignId = campaignId
    }

    enum CodingKeys: String, CodingKey {
        case audience
        case componentId
        case contentSource
        case printId
        case logic
        case position
        case flow
        case campaignId
    }
}
