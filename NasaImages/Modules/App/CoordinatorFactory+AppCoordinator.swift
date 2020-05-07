//
//  CoordinatorFactory+AppCoordinator.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

extension CoordinatorFactoryImp {
    func makeAppCoordinator(with rootController: NavigationController) -> AppCoordinator {
        let appCoordinator = AppCoordinator(
            router: RouterImp(rootController: rootController),
            coordinatorFactory: CoordinatorFactoryImp()
        )
        return appCoordinator
    }
}
