//
//  PaymentRequestInfos.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 15/07/21.
//

import Foundation

enum PaymentRequestInfos {
    case getInit(preferenceId: String?, privateKey: String?, body: Data?, headers: [String: String]?)
}

extension PaymentRequestInfos: RequestInfos {
    var endpoint: String {
        switch self {
        case .getInit(let preferenceId, _, _, _):
            if let preferenceId = preferenceId {
                return "px_mobile/v2/checkout/\(preferenceId)"
            } else {
                return "px_mobile/v2/checkout"
            }

        }
    }

    var method: HTTPMethodType {
        return .post
    }

    var body: Data? {
        switch self {
        case .getInit(_, _, let body, _): return body
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getInit(_, _, _, let header): return header
        }
    }

    var parameters: [String : Any]? {
        switch self {
        case .getInit(_, _, _, _): return nil
        }
    }
    
    var accessToken: String? {
        switch self {
        case .getInit(_, let accessToken, _, _):
        if let token = accessToken { return token } else { return nil }
        }
    }
    
    var mockURL: URL? {
        return nil
    }
}
