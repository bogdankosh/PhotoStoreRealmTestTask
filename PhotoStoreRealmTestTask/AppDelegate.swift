//
//  AppDelegate.swift
//  PhotoStoreRealmTestTask
//
//  Created by Bogdan Koshyrets on 9/14/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: PhotoTableViewController(style: .plain))
        window?.makeKeyAndVisible()


        // Delete everything from the database (for debuging)
    /*
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
    */
        
        return true
    }
}

