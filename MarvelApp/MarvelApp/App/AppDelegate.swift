//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by GOKHAN on 20.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        app.router.start()
        
        return true
    }
}

