//
//  AppDelegate.swift
//  trySwift
//
//  Created by Natasha Murashev on 2/9/16.
//  Copyright © 2016 NatashaTheRobot. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        configureStyling()
        NetworkManager.refreshJSONData { updated, version in
            print("updated JSON file: \(updated ? "yes" : "no"), version: \(version)")
            
            if WCSession.isSupported() {
                let watchSession = WCSession.defaultSession()
                watchSession.delegate = self
                watchSession.activateSession()
                if watchSession.paired && watchSession.watchAppInstalled {
                    do {
                        try watchSession.updateApplicationContext(["version": version])
                    } catch {
                        print(error)
                    }
                }
            }
            
            
            guard updated else { return }
            // Use updated json file in app
        }
        
        NSTimeZone.setDefaultTimeZone(NSTimeZone(abbreviation: "JST")!)
        return true
    }
}

extension AppDelegate: WCSessionDelegate { }

private extension AppDelegate {
    
    func configureStyling() {
        
        let tintColor = UIColor.trySwiftMainColor()
        
        window?.tintColor = tintColor
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(18)
        ]
        
        UINavigationBar.appearance().barTintColor = tintColor
        UINavigationBar.appearance().tintColor = .whiteColor()
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().barStyle = .BlackTranslucent
    }
}
