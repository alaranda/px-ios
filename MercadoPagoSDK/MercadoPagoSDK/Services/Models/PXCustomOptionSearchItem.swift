import Foundation
/// :nodoc:
open class PXCustomOptionSearchItem: NSObject, Codable {
    open var id: String
    open var _description: String?
    open var paymentMethodId: String?
    open var paymentTypeId: String?
    open var discountInfo: String?
    open var couponToApply: String?
    open var selectedPaymentOption: PXAmountConfiguration?
    open var paymentOptions: [String: PXAmountConfiguration]?
    open var comment: String?
    open var issuer: PXIssuer?
    open var firstSixDigits: String
    open var lastFourDigits: String
    open var escStatus: String?
    open var displayInfo: PXPayerPaymentMethodDisplayInfo?

    public init(id: String, description: String?, paymentMethodId: String?, paymentTypeId: String?, discountInfo: String?, defaultAmountConfiguration: String?, amountConfigurations: [String: PXAmountConfiguration]?, comment: String?, issuer: PXIssuer?, firstSixDigits: String, lastFourDigits: String, escStatus: String?, displayInfo: PXPayerPaymentMethodDisplayInfo?) {
        self.id = id
        self._description = description
        self.paymentMethodId = paymentMethodId
        self.paymentTypeId = paymentTypeId
        self.discountInfo = discountInfo
        self.couponToApply = defaultAmountConfiguration
        self.paymentOptions = amountConfigurations
        self.comment = comment
        self.issuer = issuer
        self.firstSixDigits = firstSixDigits
        self.lastFourDigits = lastFourDigits
        self.escStatus = escStatus
        self.displayInfo = displayInfo

        if let defaultAmountConfiguration = defaultAmountConfiguration, let selectedPayerCostConfiguration = amountConfigurations?[defaultAmountConfiguration] {
            self.selectedPaymentOption = selectedPayerCostConfiguration
        }
    }

    public enum PXCustomOptionSearchItemKeys: String, CodingKey {
        case id
        case description
        case paymentMethodId = "payment_method_id"
        case paymentTypeId = "payment_type_id"
        case discountInfo = "discount_info"
        case couponToApply = "coupon_to_apply"
        case paymentOptions = "payment_options"
        case comment = "comment"
        case firstSixDigits = "first_six_digits"
        case lastFourDigits = "last_four_digits"
        case issuer
        case escStatus = "esc_status"
        case displayInfo = "display_info"
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PXCustomOptionSearchItemKeys.self)
        let id: String = try container.decode(String.self, forKey: .id)
        let description: String? = try container.decodeIfPresent(String.self, forKey: .description)
        let paymentMethodId: String? = try container.decodeIfPresent(String.self, forKey: .paymentMethodId)
        let paymentTypeId: String? = try container.decodeIfPresent(String.self, forKey: .paymentTypeId)
        let comment: String? = try container.decodeIfPresent(String.self, forKey: .comment)
        let discountInfo: String? = try container.decodeIfPresent(String.self, forKey: .discountInfo)
        let defaultAmountConfiguration: String? = try container.decodeIfPresent(String.self, forKey: .couponToApply)
        let amountConfigurations: [String: PXAmountConfiguration]? = try container.decodeIfPresent([String: PXAmountConfiguration].self, forKey: .paymentOptions)
        let issuer: PXIssuer? = try container.decodeIfPresent(PXIssuer.self, forKey: .issuer)
        let lastFourDigits: String = try container.decodeIfPresent(String.self, forKey: .lastFourDigits) ?? ""
        let firstSixDigits: String = try container.decodeIfPresent(String.self, forKey: .firstSixDigits) ?? ""
        let escStatus: String? = try container.decodeIfPresent(String.self, forKey: .escStatus) ?? PXESCStatus.APPROVED.rawValue
        let displayInfo: PXPayerPaymentMethodDisplayInfo? = try container.decodeIfPresent(PXPayerPaymentMethodDisplayInfo.self, forKey: .displayInfo)

        self.init(id: id, description: description, paymentMethodId: paymentMethodId, paymentTypeId: paymentTypeId, discountInfo: discountInfo, defaultAmountConfiguration: defaultAmountConfiguration, amountConfigurations: amountConfigurations, comment: comment, issuer: issuer, firstSixDigits: firstSixDigits, lastFourDigits: lastFourDigits, escStatus: escStatus, displayInfo: displayInfo)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PXCustomOptionSearchItemKeys.self)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self._description, forKey: .description)
        try container.encodeIfPresent(self.paymentMethodId, forKey: .paymentMethodId)
        try container.encodeIfPresent(self.paymentTypeId, forKey: .paymentTypeId)
        try container.encodeIfPresent(self.discountInfo, forKey: .discountInfo)
        try container.encodeIfPresent(self.couponToApply, forKey: .couponToApply)
        try container.encodeIfPresent(self.paymentOptions, forKey: .paymentOptions)
        try container.encodeIfPresent(self.comment, forKey: .comment)
        try container.encodeIfPresent(self.issuer, forKey: .issuer)
        try container.encodeIfPresent(self.firstSixDigits, forKey: .firstSixDigits)
        try container.encodeIfPresent(self.lastFourDigits, forKey: .lastFourDigits)
        try container.encodeIfPresent(self.escStatus, forKey: .escStatus)
        try container.encodeIfPresent(self.displayInfo, forKey: .displayInfo)
    }

    open func toJSON() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }

    open class func fromJSONToPXCustomOptionSearchItem(data: Data) throws -> PXCustomOptionSearchItem {
        return try JSONDecoder().decode(PXCustomOptionSearchItem.self, from: data)
    }

    open class func fromJSON(data: Data) throws -> [PXCustomOptionSearchItem] {
        return try JSONDecoder().decode([PXCustomOptionSearchItem].self, from: data)
    }
}
