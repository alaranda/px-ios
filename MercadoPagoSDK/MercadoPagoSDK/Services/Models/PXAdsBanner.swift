//
//  PXAdsBanner.swift
//  MercadoPagoSDKV4
//
//  Created by Alexis Aranda on 28-02-22.
//

import Foundation

@objcMembers
public class PXAdsBanner: NSObject, Codable {
    let content: PXAdsBannerContent
    let eventData: PXAdsBannerEventData
    let cId: String
    let cCategory: String

    public init(content: PXAdsBannerContent, eventData: PXAdsBannerEventData, cId: String, cCategory: String) {
        self.content = content
        self.eventData = eventData
        self.cId = cId
        self.cCategory = cCategory
    }

    enum CodingKeys: String, CodingKey {
        case content
        case eventData
        case cId
        case cCategory
    }
}
