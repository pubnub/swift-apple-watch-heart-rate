//
//  AppDelegate.swift
//  piHeartRate
//
//  Created by Elisabeth Siegle on 6/7/16.
//  Copyright © 2016 Lizzie Siegle. All rights reserved.
//

import UIKit
import HealthKit
import WatchConnectivity
import PubNub

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate, PNObjectEventListener {
    
    var window: UIWindow?
    
    let healthStore = HKHealthStore()
    
    var client : PubNub
    var config : PNConfiguration
    var channel = "iWorkout"
    
    override init() {
        config = PNConfiguration(publishKey: "pub-c-1b5f6f38-34c4-45a8-81c7-7ef4c45fd608", subscribeKey: "sub-c-a3cf770a-2c3d-11e6-8b91-02ee2ddab7fe")
        client = PubNub.clientWithConfiguration(config)
        client.subscribeToChannels([channel], withPresence: false)
        client.publish("Swift+PubNub!", toChannel: "Your_Channel", compressed: false, withCompletion: nil)
        
        super.init()
        client.addListener(self)
    }
    
    //handle new msg from 1 of channels client is subscribed to
    func client(client: PubNub!, didReceiveMessage message: PNMessageResult!) {
        print(message)
//        if message.data.actualChannel != nil {
//            //msg received on channel group, stored in message.data.subscribedChannel
//        } //if
//        else {
//            //msg received on channel, stored in same place
//        }
        
        guard message.data.actualChannel != nil else {
            print(message.data)
            return
        }
        print("Received message: \(message.data.message) on channel " +
            "\((message.data.actualChannel ?? message.data.subscribedChannel)!) at " +
            "\(message.data.timetoken)")
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.client.subscribeToChannels(["HeartRate","HeartRate2"], withPresence: false)
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // authorization from watch
    func applicationShouldRequestHealthAuthorization(application: UIApplication) {
        
        self.healthStore.handleAuthorizationForExtensionWithCompletion { success, error in
            
        }
    }
    
    
}

