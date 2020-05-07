//
//  NavigationController.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import UIKit

protocol NavigationControllerDelegate: class {
    func didPop(_ viewController: UIViewController)
}

final class NavigationController: UINavigationController {

    weak var customDelegate: NavigationControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        if
        let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
        !navigationController.viewControllers.contains(poppedViewController) {
            customDelegate?.didPop(poppedViewController)
        }
    }
}
