//
//  ImagesListFactoryExtension.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesService
import NASAImagesNetwork

extension ModuleFactoryImp: ImagesListFactory {
    func makeImagesListView() -> ImagesListView {
        let viewModel = ImagesListViewModel(
            searchRequester: SearchRequester(
                apiManager: ApiManager(),
                apiUrlsProvider: ApiUrlsProvider()
            )
        )
        let viewController = ImagesListViewController(viewModel: viewModel)
        return viewController
    }
}
