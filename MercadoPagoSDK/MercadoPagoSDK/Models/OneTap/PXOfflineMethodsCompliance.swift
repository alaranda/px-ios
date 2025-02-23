import Foundation

/// :nodoc:
@objcMembers
open class PXOfflineMethodsCompliance: NSObject, Codable {
    let turnComplianceDeepLink: String
    let isCompliant: Bool
    let sensitiveInformation: PXSensitiveInformation?

    enum CodingKeys: String, CodingKey {
        case turnComplianceDeepLink = "turn_compliance_deep_link"
        case isCompliant = "is_compliant"
        case sensitiveInformation = "sensitive_information"
    }
}
