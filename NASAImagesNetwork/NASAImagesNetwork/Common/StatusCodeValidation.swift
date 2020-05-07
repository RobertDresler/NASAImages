//
//  StatusCodeValidation.swift
//  network
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 EuroSouvenir. All rights reserved.
//

public enum StatusCodeValidation: Equatable {

    case info(statusCode: Int)
    case success(statusCode: Int)
    case redirection(statusCode: Int)
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case notValid

    public init(_ statusCode: Int?) {
        guard let statusCode = statusCode else {
            self = .notValid
            return
        }

        switch statusCode {
        case 100...199:
            self = .info(statusCode: statusCode)
        case 200...299:
            self = .success(statusCode: statusCode)
        case 300...399:
            self = .redirection(statusCode: statusCode)
        case 400...499:
            self = .clientError(statusCode: statusCode)
        case 500...599:
            self = .serverError(statusCode: statusCode)
        default:
            self = .notValid
        }
    }

}
