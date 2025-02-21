import Foundation

/// :nodoc
@objc public enum PXCustomTranslationKey: Int {
    @available(*, deprecated, message: "Groups flow will no longer be available")
    case total_to_pay
    case total_to_pay_onetap
    @available(*, deprecated, message: "Groups flow will no longer be available")
    case how_to_pay
    case pay_button
    case pay_button_progress

    var getValue: String {
        switch self {
        case .total_to_pay, .total_to_pay_onetap: return "total_row_title_default"
        case .how_to_pay: return "¿Cómo quieres pagar?"
        case .pay_button: return "Pagar"
        case .pay_button_progress: return "Procesando tu pago"
        }
    }

    var description: String {
        switch self {
        case .total_to_pay: return "total_to_pay"
        case .total_to_pay_onetap: return "total_to_pay_onetap"
        case .how_to_pay: return "how_to_pay"
        case .pay_button: return "pay_button"
        case .pay_button_progress: return "pay_button_progress"
        }
    }
}
