//
//  ApiResultError.swift
//  network
//
//  Created by Robert Dresler on 06/04/2020.
//  Copyright © 2020 EuroSouvenir. All rights reserved.
//

// TODO: -RD- add localization + R.swift to network
public enum ApiResultError: Error, Equatable {
    case parsingError
    case userNotLoggedIn
    case badRequest
    case timeOut
    case noDataReceived
    case wrongStatusCode(StatusCodeValidation)
}
