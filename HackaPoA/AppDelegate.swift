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
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let initVc = VolunteerProfileViewController()
        window?.rootViewController = initVc
        window?.makeKeyAndVisible()
        
        return true
    }

}

