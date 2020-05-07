//
//  ImageDetailCoordinator.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import UIKit

protocol ImageDetailCoordinatorOutputDelegate: class {
    func imageDetailCoordinatorDidFinish(_ coordinator: ImageDetailCoordinator)
}

protocol ImageDetailCoordinatorOutput {
    var delegate: ImageDetailCoordinatorOutputDelegate? { get set }
}

final class ImageDetailCoordinator: BaseCoordinator, ImageDetailCoordinatorOutput {

    weak var delegate: ImageDetailCoordinatorOutputDelegate?

    private let router: Router
    private var imageDetailRouter: Router?
    private let factory: ImageDetailFactory
    private let image: NASAImage

    init(router: Router, factory: ImageDetailFactory, image: NASAImage) {
        self.router = router
        self.factory = factory
        self.image = image
    }

    override func start() {
        showImageDetailView()
    }

    private func showImageDetailView() {
        let navigationController = NavigationController()
        imageDetailRouter = RouterImp(rootController: navigationController)

        let imageDetailView = factory.makeImageDetailView(with: image)
        imageDetailView.delegate = self
        imageDetailRouter?.push(imageDetailView)
        router.presentOverFullScreen(navigationController)
    }

}

extension ImageDetailCoordinator: ImageDetailViewDelegate {
    func imageDetailViewDidTapCancelButton() {
        router.dismissModule()
        delegate?.imageDetailCoordinatorDidFinish(self)
    }
}
