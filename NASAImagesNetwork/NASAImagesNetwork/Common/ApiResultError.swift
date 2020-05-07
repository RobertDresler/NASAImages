//
//  ApiResultError.swift
//  network
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 EuroSouvenir. All rights reserved.
//

public enum ApiResultError: LocalizedError, Equatable {

    case parsingError
    case badRequest
    case timeOut
    case noInternetConnection
    case wrongStatusCode(StatusCodeValidation)

    public var errorDescription: String? {
        switch self {
        case .parsingError, .badRequest:
            return R.string.localizable.unexpectedErrorOccurred()
        case .timeOut:
            return R.string.localizable.timeout()
        case .noInternetConnection:
            return R.string.localizable.noInternetConnection()
        case .wrongStatusCode(let statusCode):
            switch statusCode {
            case .serverError:
                return R.string.localizable.serverError()
            default:
                return R.string.localizable.unexpectedErrorOccurred()
            }
        }
    }

}
