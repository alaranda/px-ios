//
//  PXAdsBannerData.swift
//  MercadoPagoSDKV4
//
//  Created by Alexis Aranda on 28-02-22.
//

import Foundation
import MLBusinessComponents

class PXAdsBannerData: NSObject, MLBusinessAdsBannerData {
    let banner: PXAdsBanner

    init(banner: PXAdsBanner) {
        self.banner = banner
    }

    func getImageUrl() -> String {
        return banner.content.imgUrl
    }

    func getDeepLink() -> String {
        return banner.content.deepLink
    }

    func getClickUrl() -> String {
        return banner.content.destinationUrl
    }

    func getPrintUrl() -> String {
        return banner.content.printUrl
    }
}
