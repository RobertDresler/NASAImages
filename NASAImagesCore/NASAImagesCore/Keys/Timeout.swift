//
//  Timeout.swift
//  NASAImagesCore
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

public typealias Timeout = TimeInterval

public extension Timeout {
    static let short: Timeout = 5
    static let long: Timeout = 60
}
