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

    // swiftlint:disable:next line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let apiClient = APIClient(baseURL: "http://localhost:7777/api/")
        let jsonDecoder = JSONDecoder()

        // Inject dependencies to root view, this view will be passing them down to all the pther views.
        if let loginView = window?.rootViewController as? LoginViewController {
            loginView.setDependencies(apiClient: apiClient, jsonDecoder: jsonDecoder)
        }

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
