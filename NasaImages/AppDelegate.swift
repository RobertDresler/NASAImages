//
//  AppDelegate.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesUI
import UIKit

#if NETFOX
import netfox
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var rootController: NavigationController {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = NavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.tintColor = Color.globalTint
        return navigationController
    }

    private var appCoordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupNetfoxIfNeeded()
        runAppCoordinator()
        return true
    }

    private func setupNetfoxIfNeeded() {
        #if NETFOX
        NFX.sharedInstance().start()
        #endif
    }

    private func runAppCoordinator() {
        appCoordinator = CoordinatorFactoryImp().makeAppCoordinator(with: rootController)
        appCoordinator?.start()
    }

}
