//
//  ProductionUrls.swift
//  NASAImagesCore
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

public struct ProductionUrls: ApiUrls {

    private static let base = "https://images-api.nasa.gov"

    public let search = base + "/search"

    public init() {}

}
