import Foundation

protocol TrackingEvents {
    var name: String { get }
    var properties: [String: Any] { get }
    var needsExternalData: Bool { get }
}
