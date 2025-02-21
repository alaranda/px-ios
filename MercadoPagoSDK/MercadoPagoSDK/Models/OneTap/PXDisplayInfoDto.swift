import Foundation

/// :nodoc:
public struct PXDisplayInfoDto: Codable {
    let color: String
    let gradientColors: [String]?
    let topText: PXTermsDto
    let bottomText: PXTermsDto

    enum CodingKeys: String, CodingKey {
        case color
        case gradientColors = "gradient_colors"
        case topText = "top_text"
        case bottomText = "bottom_text"
    }
}
