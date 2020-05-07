//
//  ImagesListFactoryExtension.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

extension ModuleFactoryImp: ImagesListFactory {
    func makeImagesListView() -> ImagesListView {
        let viewModel = ImagesListViewModel()
        let viewController = ImagesListViewController(viewModel: viewModel)
        return viewController
    }
}
