//
//  BaseView.swift
//  NASAImagesCore
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import Foundation

public protocol BaseView: NSObjectProtocol, Presentable, BaseViewSettings {}

public protocol BaseViewSettings {
    var showLogo: Bool { get set }
    var hidesBottomBarWhenPushed: Bool { get set }
}
