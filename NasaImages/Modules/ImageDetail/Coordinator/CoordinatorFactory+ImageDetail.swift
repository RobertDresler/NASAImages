//
//  CoordinatorFactory+ImageDetail.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore

extension CoordinatorFactoryImp {
    func makeImageDetailCoordinator(
        with router: Router,
        image: NASAImage
    ) -> Coordinator & ImageDetailCoordinatorOutput {
        let coordinator = ImageDetailCoordinator(router: router, factory: ModuleFactoryImp(), image: image)
        return coordinator
    }
}
