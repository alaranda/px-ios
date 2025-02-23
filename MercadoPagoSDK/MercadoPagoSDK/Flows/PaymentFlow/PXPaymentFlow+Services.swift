import Foundation

extension PXPaymentFlow {
    func createPaymentWithPlugin(plugin: PXSplitPaymentProcessor?, programId: String?) {
        guard let plugin = plugin else {
            showError()
            return
        }

        if let programId = programId {
            PXCheckoutStore.sharedInstance.validationProgramId = programId
        }

        strategyTracking.getPropertieFlow(flow: "createPaymentWithPlugin")

        plugin.didReceive?(checkoutStore: PXCheckoutStore.sharedInstance)

        plugin.startPayment?(checkoutStore: PXCheckoutStore.sharedInstance, errorHandler: self as PXPaymentProcessorErrorHandler, successWithBasePayment: { [weak self] basePayment in
            self?.handlePayment(basePayment: basePayment)
        })
    }

    func createPayment(programId: String?) {
        strategyTracking.getPropertieFlow(flow: "createPayment, isPaymenttoggle \(isPaymentToggle)")

        guard model.amountHelper?.getPaymentData() != nil, model.checkoutPreference != nil else {
            showError()
            return
        }

        model.assignToCheckoutStore(programId: programId)

        guard let paymentBody = (try? JSONEncoder().encode(PXCheckoutStore.sharedInstance)) else {
            fatalError("Cannot make payment json body")
        }

        var headers: [String: String] = [:]
        if let productId = model.productId {
            headers[HeaderFields.productId.rawValue] = productId
        }
        headers[HeaderFields.idempotencyKey.rawValue] = model.generateIdempotecyKey()
        headers[HeaderFields.security.rawValue] = PXCheckoutStore.sharedInstance.getSecurityType()
        headers[HeaderFields.profileID.rawValue] = PXConfiguratorManager.profileIDProtocol.getProfileID()

        model.mercadoPagoServices.createPayment(url: PXServicesURLConfigs.MP_API_BASE_URL, uri: PXServicesURLConfigs.shared().MP_PAYMENTS_URI, paymentDataJSON: paymentBody, query: nil, headers: headers, callback: { [weak self] payment in
            self?.handlePayment(payment: payment)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.trackPaymentsApiError()
            let mpError = MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.CREATE_PAYMENT.rawValue)

            guard let apiException = mpError.apiException else {
                self.showError(error: mpError)
                return
            }

            // ESC Errors
            if apiException.containsCause(code: ApiUtil.ErrorCauseCodes.INVALID_ESC.rawValue) {
                self.paymentErrorHandler?.escError(reason: .INVALID_ESC)
            } else if apiException.containsCause(code: ApiUtil.ErrorCauseCodes.INVALID_FINGERPRINT.rawValue) {
                self.paymentErrorHandler?.escError(reason: .INVALID_FINGERPRINT)
            } else if apiException.containsCause(code: ApiUtil.ErrorCauseCodes.INVALID_PAYMENT_WITH_ESC.rawValue) {
                self.paymentErrorHandler?.escError(reason: .ESC_CAP)
            } else {
                self.showError(error: mpError)
            }
        })
    }

    func getPointsAndDiscounts() {
        strategyTracking.getPropertieFlow(flow: "getPointsAndDiscounts")

        var paymentIds = [String]()
        var paymentMethodsIds = [String]()
        if let split = splitAccountMoney, let paymentMethod = split.paymentMethod?.id {
            paymentMethodsIds.append(paymentMethod)
        }
        if let paymentResult = model.paymentResult {
            if let paymentId = paymentResult.paymentId {
                paymentIds.append(paymentId)
            }
            if let paymentMethodId = paymentResult.paymentData?.paymentMethod?.id {
                paymentMethodsIds.append(paymentMethodId)
            }
        } else if let businessResult = model.businessResult {
            if let receiptLists = businessResult.getReceiptIdList() {
                paymentIds = receiptLists
            } else if let receiptId = businessResult.getReceiptId() {
                paymentIds.append(receiptId)
            }
            if let paymentMethodId = businessResult.getPaymentMethodId() {
                paymentMethodsIds.append(paymentMethodId)
            }
        }

        let campaignId: String? = model.amountHelper?.campaign?.id?.stringValue

        // ifpe is always false until KyC callback can return to one tap
        let ifpe = false

        var headers: [String: String] = [:]

        if let productId = model.productId {
            headers[HeaderFields.productId.rawValue] = productId
        }

        headers[HeaderFields.locationEnabled.rawValue] = LocationService.isLocationEnabled() ? "true" : "false"

        model.shouldSearchPointsAndDiscounts = false
        let platform = MLBusinessAppDataService().getAppIdentifier().rawValue
        model.mercadoPagoServices.getPointsAndDiscounts(
            url: PXServicesURLConfigs.MP_API_BASE_URL,
            uri: PXServicesURLConfigs.shared().MP_POINTS_URI,
            paymentIds: paymentIds,
            paymentMethodsIds: paymentMethodsIds,
            campaignId: campaignId,
            prefId: model.checkoutPreference?.id,
            platform: platform,
            ifpe: ifpe,
            merchantOrderId: model.checkoutPreference?.merchantOrderId,
            headers: headers,
            paymentTypeId: model.businessResult?.getPaymentMethodTypeId(),
            callback: { [weak self] pointsAndBenef in
                guard let self = self else { return }
                self.model.pointsAndDiscounts = pointsAndBenef
                self.model.instructionsInfo = pointsAndBenef.instruction
                self.executeNextStep()
            },
            failure: { [weak self] () in
                guard let self = self else { return }
                self.executeNextStep()
            }
        )
    }
}

// MARK: Tracking
private extension PXPaymentFlow {
    func trackPaymentsApiError() {
        let lastVC = self.pxNavigationHandler.navigationController.viewControllers.last
        if let securityCodeVC = lastVC as? PXSecurityCodeViewController {
            securityCodeVC.trackEvent(event: GeneralErrorTrackingEvents.error(
                securityCodeVC.viewModel.getFrictionProperties(path: TrackingPaths.Events.SecurityCode.getPaymentsFrictionPath(), id: "payments_api_error")
            ))
        }
    }
}
