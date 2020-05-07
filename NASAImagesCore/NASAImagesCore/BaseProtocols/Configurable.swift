//
//  Configurable.swift
//  NASAImagesCore
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

public protocol Configurable {
    associatedtype ViewModel
    func configure(for viewModel: ViewModel)
}

public extension Configurable {
    func configured(for viewModel: ViewModel) -> Self {
        configure(for: viewModel)
        return self
    }
}
