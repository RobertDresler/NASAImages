//
//  CoordinatorFactory+ImagesList.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore

extension CoordinatorFactoryImp {
    func makeImagesListCoordinator(with router: Router) -> Coordinator {
        let coordinator = ImagesListCoordinator(
            router: router,
            factory: ModuleFactoryImp(),
            coordinatorFactory: CoordinatorFactoryImp()
        )
        return coordinator
    }
}
