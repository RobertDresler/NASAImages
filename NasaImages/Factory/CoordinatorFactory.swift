//
//  CoordinatorFactory.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import UIKit

protocol CoordinatorFactory {
    func makeAppCoordinator(with rootController: NavigationController) -> AppCoordinator
    // TODO: -RD- implement
    //func makeImagesListCoordinator(with router: Router) -> Coordinator
    //func makeImageDetailCoordinator(with router: Router) -> Coordinator
}
