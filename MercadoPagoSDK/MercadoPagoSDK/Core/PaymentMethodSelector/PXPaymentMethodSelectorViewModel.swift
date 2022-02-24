import Foundation

class PXPaymentMethodSelectorViewModel {
    weak var delegate: PXPaymentMehtodSelectorDelegate?
    
    var selectedPaymentMethodId: String? = nil

    var pxNavigationHandler: PXNavigationHandler = PXNavigationHandler.getDefault()
    
    var search: PXInitDTO?
    
    // OneTap Flow
    var onetapFlow: OneTapFlow?

    func setNavigationHandler(handler: PXNavigationHandler) {
        pxNavigationHandler = handler
    }
    
    func clean() {
        // TODO: Clean missing flows
        onetapFlow = nil
    }
    
    func getSelectedPaymentMethod() -> String? {
        return selectedPaymentMethodId
    }
    
//    func createPaymentFlow(paymentErrorHandler: PXPaymentErrorHandlerProtocol) -> PXPaymentFlow {
//        guard let paymentFlow = paymentFlow else {
//            return buildPaymentFlow(with: paymentErrorHandler)
//        }
//        paymentFlow.model.amountHelper = amountHelper
//        paymentFlow.model.checkoutPreference = checkoutPreference
//        return paymentFlow
//    }
//
//    func buildPaymentFlow(with paymentErrorHandler: PXPaymentErrorHandlerProtocol) -> PXPaymentFlow {
//        let paymentFlow = PXPaymentFlow(
//            paymentPlugin: paymentPlugin,
//            mercadoPagoServices: mercadoPagoServices,
//            paymentErrorHandler: paymentErrorHandler,
//            navigationHandler: pxNavigationHandler,
//            amountHelper: amountHelper,
//            checkoutPreference: checkoutPreference,
//            ESCBlacklistedStatus: search?.configurations?.ESCBlacklistedStatus
//        )
//        if let productId = advancedConfig.productId {
//            paymentFlow.setProductIdForPayment(productId)
//        }
//        paymentFlow.model.postPaymentStatus = postPaymentNotificationName.flatMap(PostPaymentStatus.pending)
//        self.paymentFlow = paymentFlow
//        return paymentFlow
//    }
}
