//
//  AppDelegate.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureWindow()
        return true
    }
}

private extension AppDelegate {
    func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TattooListScreen().createAsRoot()
        window?.makeKeyAndVisible()
    }
}

