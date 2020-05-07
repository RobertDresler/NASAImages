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
    func makeImagesListCoordinator(with router: Router) -> Coordinator
    // TODO: -RD- implement
    //func makeImageDetailCoordinator(with router: Router) -> Coordinator
}
