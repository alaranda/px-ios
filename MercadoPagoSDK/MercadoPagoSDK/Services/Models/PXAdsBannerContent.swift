//
//  PXAdsBannerContent.swift
//  MercadoPagoSDKV4
//
//  Created by Alexis Aranda on 28-02-22.
//

import Foundation

@objcMembers
public class PXAdsBannerContent: NSObject, Codable {
    let contentId: String
    let markUp: String
    let imgUrl: String
    let deepLink: String
    let destinationUrl: String
    let printUrl: String

    public init(contentId: String, markUp: String, imgUrl: String, deepLink: String, destinationUrl: String, printUrl: String) {
        self.contentId = contentId
        self.markUp = markUp
        self.imgUrl = imgUrl
        self.deepLink = deepLink
        self.destinationUrl = destinationUrl
        self.printUrl = printUrl
    }

    enum CodingKeys: String, CodingKey {
        case contentId = "content_id"
        case markUp = "markup"
        case imgUrl = "image_url"
        case deepLink = "deeplink"
        case destinationUrl = "destination_url"
        case printUrl = "print_url"
    }
}
