import Foundation

public class PXPaymentMethodSelector: NSObject {
    var viewModel: PXPaymentMethodSelectorViewModel?

    var accessToken: String?

    var dynamicDialogConfiguration: AnyObject?

    var customStringConfiguration: AnyObject?

    var discountParamsConfiguration: AnyObject?

    var productId: AnyObject?

    var chargeRules: AnyObject?

    var trackingConfiguration: AnyObject?

    private init(accessToken: String) {
        self.accessToken = accessToken
        self.viewModel = PXPaymentMethodSelectorViewModel()
    }

    public class Builder {
        var accessToken: String?
        var publicKey: String?
        var preferenceId: String?
        var dynamicDialogConfiguration: AnyObject?
        var customStringConfiguration: AnyObject?
        var discountParamsConfiguration: AnyObject?
        var productId: AnyObject?
        var chargeRules: AnyObject?
        var trackingConfiguration: AnyObject?

        public init(publicKey: String, preferenceId: String) {
            self.publicKey = publicKey
            self.preferenceId = preferenceId
        }

        public func setAccessToken(accessToken: String) {
            self.accessToken = accessToken
        }

        public func build() throws -> PXPaymentMethodSelector? {
            guard let accessToken = accessToken else {
                throw PXPaymentMethodSelectorError.missingAccessToken
            }

            print(accessToken)

            return PXPaymentMethodSelector(accessToken: accessToken)
        }
    }

    // TODO: Remove this after mock
    public func setSelectedPaymentMethod(_ paymentMethodId: String) {
        viewModel?.selectedPaymentMethodId = paymentMethodId
    }
}

public enum PXPaymentMethodSelectorError: Error {
    case missingAccessToken
}

public protocol PXPaymentMehtodSelectorDelegate: AnyObject {
    func didSelectedPaymentMethod() -> ((_ checkoutStore: PXCheckoutStore) -> Void)?

    /**
     User cancel checkout. By any cancel UI button or back navigation action. You can return an optional block, to override the default exit cancel behavior. Default exit cancel behavior is back navigation stack.
     */
    func didCanceledPaymentMethodSelection() -> (() -> Void)?
}

extension PXPaymentMethodSelector {
    public func start(navigationController: UINavigationController, delegate: PXPaymentMehtodSelectorDelegate?=nil) {
        viewModel?.delegate = delegate

        PXTrackingStore.sharedInstance.initializeInitDate()

        // TODO: Check flow usage
//        viewModel.setInitFlowProtocol(flowInitProtocol: self)

        // TODO: Check plugin usage, plugin is like "CustomProcessor"
//        if !viewModel.shouldApplyDiscount() {
//            viewModel.clearDiscount()
//        }

        ThemeManager.shared.initialize()

        viewModel?.setNavigationHandler(handler: PXNavigationHandler(navigationController: navigationController))

        ThemeManager.shared.saveNavBarStyleFor(navigationController: navigationController)

        viewModel?.pxNavigationHandler.presentInitLoading()

//        executeNextStep()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.closeCheckout()
        }
    }

//    func startOneTapFlow() {
//        guard let search = viewModel?.search else { return }
//
//        if viewModel?.onetapFlow == nil {
//            viewModel.onetapFlow = OneTapFlow(checkoutViewModel: viewModel, search: search, paymentOptionSelected: viewModel.paymentOptionSelected, oneTapResultHandler: self)
//        } else {
//            viewModel.onetapFlow?.update(checkoutViewModel: viewModel, search: search, paymentOptionSelected: viewModel.paymentOptionSelected)
//        }
//
//        guard let onetapFlow = viewModel.onetapFlow else {
//            // onetapFlow shouldn't be nil by this point
//            return
//        }
//
//        onetapFlow.setCustomerPaymentMethods(viewModel.customPaymentOptions)
//
//        if shouldUpdateOnetapFlow() {
//            onetapFlow.updateOneTapViewModel(cardId: InitFlowRefresh.cardId ?? "")
//        } else {
//            onetapFlow.start()
//        }
//
//        InitFlowRefresh.resetValues()
//    }

    func closeCheckout() {
        commonFinish()
        // delegate.finishCheckout - defined
        // Exit checkout with payment. (by closeAction)
//        if viewModel.getGenericPayment() != nil {
//            let result = viewModel.getResult()
//            if let finishCallback = viewModel.lifecycleProtocol?.finishCheckout() {
//                finishCallback(result)
//            } else {
//                defaultExitAction()
//            }
//            return
//        }
        if let _ = viewModel?.getSelectedPaymentMethod() {
            if let didSelectedPaymentMethod = viewModel?.delegate?.didSelectedPaymentMethod() {
                return didSelectedPaymentMethod(PXCheckoutStore())
            } else {
                return defaultExitAction()
            }
        }

        // delegate.cancelCheckout - defined
        // Exit checkout without payment. (by back stack action)
        if let delegate = viewModel?.delegate, let cancelCustomAction = delegate.didCanceledPaymentMethodSelection() {
            cancelCustomAction()
            return
        }

        // Default exit. Without LifecycleProtocol returns.
        defaultExitAction()
    }

    private func commonFinish() {
        // TODO: Remove after mock
        viewModel?.pxNavigationHandler.dismissLoading()

        MPXTracker.sharedInstance.clean()
        PXCheckoutStore.sharedInstance.clean()
        PXNotificationManager.UnsuscribeTo.attemptToClose(self)
        ThemeManager.shared.applyAppNavBarStyle(navigationController: viewModel?.pxNavigationHandler.navigationController)
        viewModel?.clean()
    }

    private func defaultExitAction() {
        viewModel?.pxNavigationHandler.goToRootViewController()
    }
}

extension PXPaymentMethodSelector: PXPaymentErrorHandlerProtocol {
    func escError(reason: PXESCDeleteReason) {
        // TODO: Implement this
    }

    func exitCheckout() {
        // TODO: Implement this
    }
}
