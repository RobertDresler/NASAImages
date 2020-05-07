//
//  Presentable.swift
//  NASAImagesCore
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import UIKit

public protocol Presentable: class {
    var toPresent: UIViewController? { get }
}

extension UIViewController: Presentable {
    public var toPresent: UIViewController? {
        return self
    }
}
