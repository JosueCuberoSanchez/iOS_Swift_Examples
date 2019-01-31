//
//  AppDelegate.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    // swiftlint:disable:next line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let apiClient = APIClient(baseURL: "http://localhost:7777/api/")
        let jsonDecoder = JSONDecoder()

        guard let loginView = window?.rootViewController as? LoginViewController else {
            return false
        }

        appCoordinator = AppCoordinator(viewController: loginView, jsonDecoder: jsonDecoder)
        appCoordinator?.start()

        // Inject dependencies to root view, this view will be passing them down to all the pther views.
        //loginView.setDependencies(apiClient: apiClient, jsonDecoder: jsonDecoder, delegate: nil)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
