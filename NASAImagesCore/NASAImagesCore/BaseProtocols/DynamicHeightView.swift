//
//  DynamicHeightView.swift
//  NASAImagesCore
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import CoreGraphics

public protocol DynamicHeightView {
    static var estimatedHeight: CGFloat { get }
}
