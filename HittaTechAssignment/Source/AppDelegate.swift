//
//  AppDelegate.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 01/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard.init(name: "CompanyDetails", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
