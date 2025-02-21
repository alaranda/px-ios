import Foundation

@objcMembers
public class PXCrossSellingItem: NSObject, Codable {
    let title: String
    let icon: String
    let contentId: String
    let action: PXRemoteAction

    public init(title: String, icon: String, contentId: String, action: PXRemoteAction) {
        self.title = title
        self.icon = icon
        self.contentId = contentId
        self.action = action
    }

    enum CodingKeys: String, CodingKey {
        case title
        case icon
        case contentId = "content_id"
        case action
    }
}
