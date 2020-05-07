//
//  ViewSetupable.swift
//  NASAImagesCore
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

@objc public protocol ViewSetupable {
    func setupView()
    func addSubviews()
    func setupSubviews()
    func setupConstraints()
}

public extension ViewSetupable {
    func callSetups() {
        setupView()
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
}
