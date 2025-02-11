//
//  ExtensionDelegate.swift
//  getHeartRate Extension
//
//  Created by Elisabeth Siegle on 6/24/16.
//  Copyright © 2016 Lizzie Siegle. All rights reserved.
//

import UIKit
import WatchKit
import PubNub
import WatchConnectivity //yolo

class ExtensionDelegate: NSObject, WKExtensionDelegate, PNObjectEventListener {
    var client: PubNub?
    //    var client : PubNub
    //    var config : PNConfiguration
    //var channel = "iWorkout"

    
    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
    }
    
    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        client?.unsubscribeFromAll()
        //client?.unsubscribeFromChannels([channel], withPresence: true)
        // Use this method to pause ongoing tasks, disable timers, etc.
    }
    
}
