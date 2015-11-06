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
        let initVc = HomeViewController()
        
        let nav = UINavigationController(rootViewController: initVc)
        nav.setNavigationBarHidden(true, animated: false)
        
        let tabVC = UITabBarController()
        tabVC.setViewControllers([nav], animated: false)
        tabVC.tabBar.hidden = true
        
        window?.rootViewController = tabVC
        window?.makeKeyAndVisible()
        
        return true
    }

}

