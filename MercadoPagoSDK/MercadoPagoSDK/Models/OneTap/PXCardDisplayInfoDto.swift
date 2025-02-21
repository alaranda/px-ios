import Foundation

public enum PXCardDisplayTypes: String, Codable {
    case defaultType = "default"
    case hybrid = "hybrid"
}

/// :nodoc:
open class PXCardDisplayInfoDto: NSObject, Codable {
    open var expiration: String?
    open var firstSixDigits: String?
    open var lastFourDigits: String?
    open var issuerId: String?
    open var name: String?
    open var cardPattern: [Int]?
    open var color: String?
    open var fontColor: String?
    open var issuerImage: String?
    open var pmImage: String?
    open var fontType: String?
    open var securityCode: PXSecurityCode?
    open var paymentMethodImageUrl: String?
    open var issuerImageUrl: String?
    open var displayType: PXCardDisplayTypes?
    open var title: PXText?
    open var subtitle: PXText?
    open var gradientColor: [String]?

    public init(expiration: String?, firstSixDigits: String?, lastFourDigits: String?, issuerId: String?, name: String?, cardPattern: [Int]?, color: String?, fontColor: String?, issuerImage: String?, pmImage: String?, fontType: String?, securityCode: PXSecurityCode?, paymentMethodImageUrl: String?, issuerImageUrl: String?, title: PXText?, subtitle: PXText?, displayType: PXCardDisplayTypes?, gradientColor: [String]? = nil) {
        self.expiration = expiration
        self.firstSixDigits = firstSixDigits
        self.lastFourDigits = lastFourDigits
        self.issuerId = issuerId
        self.name = name
        self.cardPattern = cardPattern
        self.color = color
        self.fontColor = fontColor
        self.issuerImage = issuerImage
        self.pmImage = pmImage
        self.fontType = fontType
        self.securityCode = securityCode
        self.paymentMethodImageUrl = paymentMethodImageUrl
        self.issuerImageUrl = issuerImageUrl
        self.displayType = displayType
        self.title = title
        self.subtitle = subtitle
        self.gradientColor = gradientColor
    }

    public enum PXCardDisplayInfoKeys: String, CodingKey {
        case expiration
        case first_six_digits
        case last_four_digits
        case issuer_id
        case name = "cardholder_name"
        case card_pattern
        case color
        case font_color
        case issuer_image
        case pm_image = "payment_method_image"
        case font_type
        case securityCode = "security_code"
        case paymentMethodImageUrl = "payment_method_image_url"
        case issuerImageUrl = "issuer_image_url"
        case displayType = "type"
        case title
        case subtitle
        case gradientColor = "gradient_color"
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PXCardDisplayInfoKeys.self)
        let expiration: String? = try container.decodeIfPresent(String.self, forKey: .expiration)
        let firstSixDigits: String? = try container.decodeIfPresent(String.self, forKey: .first_six_digits)
        let lastFourDigits: String? = try container.decodeIfPresent(String.self, forKey: .last_four_digits)
        let issuerId: String? = try container.decodeIfPresent(String.self, forKey: .issuer_id)
        let name: String? = try container.decodeIfPresent(String.self, forKey: .name)
        let cardPattern: [Int]? = try container.decodeIfPresent([Int].self, forKey: .card_pattern)
        let color: String? = try container.decodeIfPresent(String.self, forKey: .color)
        let fontColor: String? = try container.decodeIfPresent(String.self, forKey: .font_color)
        let issuerImage: String? = try container.decodeIfPresent(String.self, forKey: .issuer_image)
        let fontType: String? = try container.decodeIfPresent(String.self, forKey: .font_type)
        let paymentMethodImage: String? = try container.decodeIfPresent(String.self, forKey: .pm_image)
        let securityCode: PXSecurityCode? = try container.decodeIfPresent(PXSecurityCode.self, forKey: .securityCode)
        let paymentMethodImageUrl: String? = try container.decodeIfPresent(String.self, forKey: .paymentMethodImageUrl)
        let issuerImageUrl: String? = try container.decodeIfPresent(String.self, forKey: .issuerImageUrl)
        let displayType: PXCardDisplayTypes? = try container.decodeIfPresent(PXCardDisplayTypes.self, forKey: .displayType)
        let title: PXText? = try container.decodeIfPresent(PXText.self, forKey: .title)
        let subtitle: PXText? = try container.decodeIfPresent(PXText.self, forKey: .subtitle)
        let gradientColor: [String]? = try container.decodeIfPresent([String].self, forKey: .gradientColor)

        self.init(expiration: expiration, firstSixDigits: firstSixDigits, lastFourDigits: lastFourDigits, issuerId: issuerId, name: name, cardPattern: cardPattern, color: color, fontColor: fontColor, issuerImage: issuerImage, pmImage: paymentMethodImage, fontType: fontType, securityCode: securityCode, paymentMethodImageUrl: paymentMethodImageUrl, issuerImageUrl: issuerImageUrl, title: title, subtitle: subtitle, displayType: displayType, gradientColor: gradientColor)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PXCardDisplayInfoKeys.self)
        try container.encodeIfPresent(self.expiration, forKey: .expiration)
        try container.encodeIfPresent(self.firstSixDigits, forKey: .first_six_digits)
        try container.encodeIfPresent(self.lastFourDigits, forKey: .last_four_digits)
        try container.encodeIfPresent(self.issuerId, forKey: .issuer_id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.cardPattern, forKey: .card_pattern)
        try container.encodeIfPresent(self.color, forKey: .color)
        try container.encodeIfPresent(self.fontColor, forKey: .font_color)
        try container.encodeIfPresent(self.issuerImage, forKey: .issuer_image)
        try container.encodeIfPresent(self.pmImage, forKey: .pm_image)
        try container.encodeIfPresent(self.fontType, forKey: .font_type)
        try container.encodeIfPresent(self.securityCode, forKey: .securityCode)
        try container.encodeIfPresent(self.displayType, forKey: .displayType)
        try container.encodeIfPresent(self.gradientColor, forKey: .gradientColor)
    }

    open func toJSONString() throws -> String? {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        return String(data: data, encoding: .utf8)
    }

    open func toJSON() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }

    open class func fromJSON(data: Data) throws -> PXCardDisplayInfoDto {
        return try JSONDecoder().decode(PXCardDisplayInfoDto.self, from: data)
    }
}
