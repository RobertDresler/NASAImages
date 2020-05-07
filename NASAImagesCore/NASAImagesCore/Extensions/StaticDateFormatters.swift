//
//  StaticDateFormatters.swift
//  NASAImagesCore
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import Foundation

public extension DateFormatter {

    /// DateFormat: **yyyy-MM-dd'T'HH:mm:ssZ**
    static let yyyyMMddTHHmmssZ = DateFormatter(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")

    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }

}
