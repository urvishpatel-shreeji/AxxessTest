//
//  AppDelegate.swift
//  AxxessTest
//
//  Created by Hemil Modi on 05/09/20.
//  Copyright © 2020 Hemil Modi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AXRechability.shared.loadRechability()
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController.init(rootViewController: ItemListController())
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    
   
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
      //  self.fireLoaclNotification(subTitle: "App Is in Not running", Message: "Alarm will not work. Please open Application for use alarm functionality")
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//         UserDefaults.standard.set(UIScreen.main.brightness as CGFloat, forKey: "_brightness_")
//        print("backgraound",UIScreen.main.brightness)
//          UIScreen.main.brightness = CGFloat(0.5)
       
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//        if UserDefaults.standard.string(forKey: "_brightness_") != nil {
//        let value = UserDefaults.standard.string(forKey: "_brightness_")
//               print("again active", value)
//            UIScreen.main.brightness = CGFloat(value ?? "0.5")!
//            UserDefaults.standard.removeObject(forKey: "_brightness_")
//        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

       
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    

}
    

