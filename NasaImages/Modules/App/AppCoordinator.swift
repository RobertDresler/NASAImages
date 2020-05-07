//
//  AppCoordinator.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import UIKit

final class AppCoordinator: BaseCoordinator {

    private let router: Router
    private let coordinatorFactory: CoordinatorFactory

    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        runImagesListCoordinator()
    }

    private func runImagesListCoordinator() {
        // TODO: -RD- implement
        //let coordinator = coordinatorFactory.makeImagesListCoordinator(with: router)
        //addChild(coordinator)
        //coordinator.start()
    }

}
