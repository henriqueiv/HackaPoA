//
//  AppDelegate.swift
//  HackaPoA
//
//  Created by Henrique Valcanaia on 11/5/15.
//  Copyright © 2015 HackaPoA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let route = "http://Hackathon-Poa.mybluemix.net"
        let appId = "14c1f7c0-1694-4982-b060-748ff99177ad"
        let secret = "5c5b55785f7e46910495ec4152d3f86875e21a79"
        IBMBluemix.initializeWithApplicationId(appId, andApplicationSecret: secret, andApplicationRoute: route)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let initVc = IntitutionsViewController()
        window?.rootViewController = initVc
        window?.makeKeyAndVisible()
        
        return true
    }

}

