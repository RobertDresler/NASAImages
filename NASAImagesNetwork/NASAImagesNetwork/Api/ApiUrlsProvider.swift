//
//  ApiUrlsProvider.swift
//  NASAImagesNetwork
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore

public class ApiUrlsProvider: ApiUrlsProvideable {

    public let urls: ApiUrls = ProductionUrls()

    public init() {}

}
