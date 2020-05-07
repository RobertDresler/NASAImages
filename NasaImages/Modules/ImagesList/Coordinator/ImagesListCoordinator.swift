//
//  ImagesListCoordinator.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import UIKit

final class ImagesListCoordinator: BaseCoordinator {

    private let router: Router
    private let factory: ImagesListFactory
    private let coordinatorFactory: CoordinatorFactory

    init(router: Router, factory: ImagesListFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        showImagesListView()
    }

    private func showImagesListView() {
        let imagesListView = factory.makeImagesListView()
        imagesListView.delegate = self
        router.setRootModule(imagesListView)
    }

}

extension ImagesListCoordinator: ImagesListViewDelegate {
    func didSelectImage(_ image: NASAImage) {
        runImageDetailCoordinator(with: image)
    }

    private func runImageDetailCoordinator(with image: NASAImage) {
        var coordinator = coordinatorFactory.makeImageDetailCoordinator(with: router, image: image)
        coordinator.delegate = self
        addChild(coordinator)
        coordinator.start()
    }
}

extension ImagesListCoordinator: ImageDetailCoordinatorOutputDelegate {
    func imageDetailCoordinatorDidFinish(_ coordinator: ImageDetailCoordinator) {
        removeChild(coordinator)
    }
}
