//
//  StaticDateFormatters.swift
//  NASAImagesCore
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import Foundation

public extension DateFormatter {

    // TODO: -RD- add static DateFormatters

    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }

}
