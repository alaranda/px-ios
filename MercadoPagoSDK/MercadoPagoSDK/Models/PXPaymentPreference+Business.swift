import Foundation

private func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l__?, r__?):
        return l__ < r__
    case (nil, _?):
        return true
    default:
        return false
    }
}

private func <= <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l__?, r__?):
        return l__ <= r__
    default:
        return !(rhs < lhs)
    }
}

private func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l__?, r__?):
        return l__ > r__
    default:
        return rhs < lhs
    }
}

extension PXPaymentPreference {
    func autoSelectPayerCost(_ payerCostList: [PXPayerCost]) -> PXPayerCost? {
        if payerCostList.count == 0 {
            return nil
        }
        if payerCostList.count == 1 {
            return payerCostList.first
        }

        for payercost in payerCostList where payercost.installments == defaultInstallments {
            return payercost
        }

        if (payerCostList.first?.installments <= maxAcceptedInstallments)
            && (payerCostList[1].installments > maxAcceptedInstallments) {
            return payerCostList.first
        } else {
            return nil
        }
    }

    func getExcludedPaymentTypesIds() -> [String] {
            return excludedPaymentTypeIds
    }

    func getDefaultInstallments() -> Int? {
        return defaultInstallments
    }

    func getMaxAcceptedInstallments() -> Int {
        return maxAcceptedInstallments > 0 ? maxAcceptedInstallments : 0
    }

    func getExcludedPaymentMethodsIds() -> [String] {
        return excludedPaymentMethodIds
    }

    func getDefaultPaymentMethodId() -> String? {
        if defaultPaymentMethodId != nil && defaultPaymentMethodId!.isNotEmpty {
            return defaultPaymentMethodId
        }
        return nil
    }

    func addSettings(_ defaultPaymentTypeId: String? = nil, excludedPaymentMethodsIds: [String] = [], excludedPaymentTypesIds: [String] = [], defaultPaymentMethodId: String? = nil, maxAcceptedInstallment: Int = 0, defaultInstallments: Int? = nil) -> PXPaymentPreference {
        self.excludedPaymentMethodIds = excludedPaymentMethodsIds
        self.excludedPaymentTypeIds = excludedPaymentTypesIds
        self.maxAcceptedInstallments = maxAcceptedInstallment
        self.defaultInstallments = defaultInstallments

        if defaultPaymentMethodId != nil {
            self.defaultPaymentMethodId = defaultPaymentMethodId
        }

        if defaultPaymentTypeId != nil {
            self.defaultPaymentTypeId = defaultPaymentTypeId
        }

        return self
    }
}
