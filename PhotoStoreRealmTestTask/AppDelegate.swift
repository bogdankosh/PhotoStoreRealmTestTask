//
//  AppDelegate.swift
//  PhotoStoreRealmTestTask
//
//  Created by Bogdan Koshyrets on 9/14/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import UIKit
import RealmSwift
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: PhotoTableViewController(style: .plain))
        window?.makeKeyAndVisible()

        setupWatchConnectivity()
        
        // Delete everything from the database (for debuging)
    /*
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
    */
        
        return true
    }
    
    // MARK: WCSessionDelegate methods
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session did become inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("WC session did deactivate")
        WCSession.default().activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WC Session activation failed with error: \(error.localizedDescription)")
            return
        }
        print("WC Session activated with state: \(activationState.rawValue)")
    }
    
    func setupWatchConnectivity() {
        if WCSession.isSupported() {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
}

