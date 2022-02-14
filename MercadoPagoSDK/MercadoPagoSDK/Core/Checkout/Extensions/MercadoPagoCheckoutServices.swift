import Foundation

extension MercadoPagoCheckout {
    func createPayment() {
        // todo - incluir track
        viewModel.invalidESCReason = nil
        let paymentFlow = viewModel.createPaymentFlow(paymentErrorHandler: self)
        paymentFlow.setData(amountHelper: viewModel.amountHelper, checkoutPreference: viewModel.checkoutPreference, resultHandler: self)
        paymentFlow.start()
    }
}
