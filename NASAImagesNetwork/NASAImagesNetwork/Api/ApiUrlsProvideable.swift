//
//  ApiUrlsProvideable.swift
//  NASAImagesNetwork
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore

public protocol ApiUrlsProvideable {
    var urls: ApiUrls { get }
}
