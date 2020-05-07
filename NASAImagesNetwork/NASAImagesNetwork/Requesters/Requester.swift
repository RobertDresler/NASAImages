//
//  Requester.swift
//  NASAImagesNetwork
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore

public class Requester {

    let apiManager: ApiManageable
    let apiUrlsProvider: ApiUrlsProvideable

    public init(apiManager: ApiManageable, apiUrlsProvider: ApiUrlsProvideable) {
        self.apiManager = apiManager
        self.apiUrlsProvider = apiUrlsProvider
    }

}
