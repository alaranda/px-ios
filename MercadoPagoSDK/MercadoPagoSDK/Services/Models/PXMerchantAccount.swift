import UIKit

/**
 Support for gateway mode
 */

@objcMembers
open class PXMerchantAccount: Codable {
    let merchantId: String
    let branchId: String?
    let paymentMethodOptionId: String

    enum CodingKeys: String, CodingKey {
        case merchantId = "id"
        case branchId = "branch_id"
        case paymentMethodOptionId = "payment_method_option_id"
    }
}
