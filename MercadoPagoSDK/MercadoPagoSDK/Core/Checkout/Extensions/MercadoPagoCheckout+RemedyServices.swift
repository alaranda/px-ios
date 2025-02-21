import Foundation

extension MercadoPagoCheckout {
    private func getAlternativePayerPaymentMethods(from customOptionSearchItems: [PXCustomOptionSearchItem]?) -> [PXRemedyPaymentMethod]? {
        guard let customOptionSearchItems = customOptionSearchItems else { return nil }

        var alternativePayerPaymentMethods: [PXRemedyPaymentMethod] = []
        for customOptionSearchItem in customOptionSearchItems {
            let oneTapCard = getOneTapCard(cardId: customOptionSearchItem.id)
            let installments = getInstallments(from: customOptionSearchItem.selectedPaymentOption?.payerCosts)
            let alternativePayerPaymentMethod = PXRemedyPaymentMethod(bin: customOptionSearchItem.firstSixDigits,
                                                                      customOptionId: customOptionSearchItem.id,
                                                                      paymentMethodId: customOptionSearchItem.paymentMethodId,
                                                                      paymentTypeId: customOptionSearchItem.paymentTypeId,
                                                                      escStatus: customOptionSearchItem.escStatus ?? "not_available",
                                                                      issuerName: customOptionSearchItem.issuer?.name,
                                                                      lastFourDigit: customOptionSearchItem.lastFourDigits,
                                                                      securityCodeLocation: oneTapCard?.cardUI?.securityCode?.cardLocation,
                                                                      securityCodeLength: oneTapCard?.cardUI?.securityCode?.length,
                                                                      installmentsList: installments,
                                                                      installment: nil,
                                                                      cardSize: nil)
            alternativePayerPaymentMethods.append(alternativePayerPaymentMethod)
        }
        return alternativePayerPaymentMethods
    }

    private func getOneTapCard(cardId: String) -> PXOneTapCardDto? {
        return viewModel.search?.oneTap?.first(where: { $0.oneTapCard?.cardId == cardId })?.oneTapCard
    }

    private func getInstallments(from payerCosts: [PXPayerCost]?) -> [PXPaymentMethodInstallment]? {
        guard let payerCosts = payerCosts else { return nil }

        var paymentMethodInstallments: [PXPaymentMethodInstallment] = []
        for payerCost in payerCosts {
            let paymentMethodInstallment = PXPaymentMethodInstallment(installments: payerCost.installments,
                                                                      totalAmount: payerCost.totalAmount)
            paymentMethodInstallments.append(paymentMethodInstallment)
        }
        return paymentMethodInstallments
    }

    func getRemedy() {
        guard let paymentResult = viewModel.paymentResult,
              let paymentId = paymentResult.paymentId,
              let paymentData = paymentResult.paymentData else {
            viewModel.updateCheckoutModel(remedy: PXRemedy())
            executeNextStep()
            return
        }

        var cardId = paymentResult.cardId ?? paymentData.token?.cardId
        var securityCode: PXSecurityCode?
        if let cardId = cardId {
            // oneTapCard has the info about securityCode location and length
            let oneTapCard = getOneTapCard(cardId: cardId)
            securityCode = oneTapCard?.cardUI?.securityCode
        }

        let paymentMethodId = paymentData.paymentMethod?.id
        if [PXPaymentTypes.ACCOUNT_MONEY.rawValue, PXPaymentTypes.CONSUMER_CREDITS.rawValue].contains(paymentMethodId) {
            // ACCOUNT_MONEY and CONSUMER_CREDITS have no cardId and should be searched by paymentMethodId
            cardId = paymentMethodId
        }

        if paymentMethodId == PXPaymentMethodId.DEBIN.rawValue {
            cardId = paymentData.transactionInfo?.bankInfo?.accountId
        }

        guard let customOptionSearchItem = viewModel.search?.getPayerPaymentMethod(id: cardId, paymentMethodId: paymentMethodId, paymentTypeId: paymentData.paymentMethod?.paymentTypeId),
              customOptionSearchItem.isCustomerPaymentMethod() else {
            viewModel.updateCheckoutModel(remedy: PXRemedy())
            executeNextStep()
            return
        }

        let payerPaymentMethodRejected = PXPayerPaymentMethodRejected(bin: customOptionSearchItem.firstSixDigits,
                                                                      customOptionId: customOptionSearchItem.id,
                                                                      paymentMethodId: customOptionSearchItem.paymentMethodId,
                                                                      paymentTypeId: customOptionSearchItem.paymentTypeId,
                                                                      issuerName: customOptionSearchItem.issuer?.name,
                                                                      lastFourDigit: customOptionSearchItem.lastFourDigits,
                                                                      securityCodeLocation: securityCode?.cardLocation,
                                                                      securityCodeLength: securityCode?.length,
                                                                      totalAmount: paymentData.payerCost?.totalAmount,
                                                                      installments: paymentData.payerCost?.installments,
                                                                      escStatus: customOptionSearchItem.escStatus,
                                                                      paymentMethodName: customOptionSearchItem.paymentMethodName,
                                                                      bankInfo: customOptionSearchItem.bankInfo)

        let remainingPayerPaymentMethods = viewModel.search?.payerPaymentMethods.filter { $0.id != cardId }
        let alternativePayerPaymentMethods = getAlternativePayerPaymentMethods(from: remainingPayerPaymentMethods)

        let customStringConfiguration = PXCustomStringConfiguration(customPayButtonProgessText: viewModel.customRemedyMessages?.customPayButtonProgessText,
                                                                    customPayButtonText: viewModel.customRemedyMessages?.customPayButtonText,
                                                                    totalDescriptionText: viewModel.customRemedyMessages?.totalDescriptionText)
        let oneTap = viewModel.search?.oneTap != nil

        viewModel.mercadoPagoServices.getRemedy(for: paymentId, payerPaymentMethodRejected: payerPaymentMethodRejected, alternativePayerPaymentMethods: alternativePayerPaymentMethods, customStringConfiguration: customStringConfiguration, oneTap: oneTap, success: { [weak self] remedy in
            guard let self = self else { return }
            self.viewModel.updateCheckoutModel(remedy: remedy)
            self.executeNextStep()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            printDebug(error)
            self.viewModel.updateCheckoutModel(remedy: PXRemedy())
            self.executeNextStep()
        })
    }
}
