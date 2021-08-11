//
//  PaymentServices.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 15/07/21.
//

protocol PaymentServices {
    func getInit(preferenceId: String?,
                 privateKey: String?,
                 body: Data?,
                 headers: [String: String]?,
                 completion: @escaping (PXInitDTO?, PXError?) -> Void)
}

final class PaymentServicesImpl: PaymentServices {
    // MARK: - Private properties
    private let service: Requesting<PaymentRequestInfos>

    // MARK: - Initialization
    init(service: Requesting<PaymentRequestInfos> = Requesting<PaymentRequestInfos>()) {
        self.service = service
    }

    // MARK: - Public methods
    func getInit(preferenceId: String?, privateKey: String?, body: Data?, headers: [String: String]?, completion: @escaping (PXInitDTO?, PXError?) -> Void) {
        service.requestObject(model: PXInitDTO.self, .getInit(preferenceId, privateKey, body, headers)) { apiResponse in
            switch apiResponse {
            case .success(let payment): completion(payment, nil)
            case .failure: completion(nil, PXError(domain: ApiDomain.GET_REMEDY,
                                                   code: ErrorTypes.NO_INTERNET_ERROR,
                                                   userInfo: [
                                                       NSLocalizedDescriptionKey: "Hubo un error",
                                                       NSLocalizedFailureReasonErrorKey: "Verifique su conexión a internet e intente nuevamente"
                                                   ]))
            }
        }
    }
}
