import Foundation

extension PXInstructionReference {
    func getFullReferenceValue() -> String {
        if String.isNullOrEmpty(separator) {
            self.separator = ""
        }
        if fieldValue.count == 0 {
            return ""
        }
        var referenceFullValue: String = fieldValue.reduce("", { ($0 as String) + self.separator + $1 })
        if self.separator != "" {
            referenceFullValue = String(referenceFullValue.dropFirst())
        }
        return referenceFullValue
    }
}
