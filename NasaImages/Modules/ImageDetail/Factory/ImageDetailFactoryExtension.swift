//
//  ImageDetailFactoryExtension.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore

extension ModuleFactoryImp: ImageDetailFactory {
    func makeImageDetailView(with image: NASAImage) -> ImageDetailView {
        let viewModel = ImageDetailViewModel(image: image)
        let viewController = ImageDetailViewController(viewModel: viewModel)
        return viewController
    }
}
