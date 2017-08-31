//
//  AppDelegate.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/29/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var coreDataStack = CoreDataStack(modelName: "Contacts")
    
    // MARK: Preload Data
    
    func preloadData() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        do {
            let fetchResults = try coreDataStack.managedObjectContext.fetch(fetchRequest)
            if fetchResults.count == 0 {
                addSampleData()
            }
            
        } catch let error as NSError {
            fatalError("Error fetching data: \(error)")
        }
    }
    
    func addSampleData() {
        
        // Create notebooks
        let putraDictionary = ["id": 123, "first_name": "Zulwiyoza", "last_name": "Putra"] as [String : Any]
        let anindaDictionary = ["id": 212, "first_name": "Aninda", "last_name": "Rahmadianti"] as [String : Any]
        let raraDictionary = ["id": 212, "first_name": "Aulia", "last_name": "Putri"] as [String : Any]
        
        let putra = Contact(dictionary: putraDictionary, context: coreDataStack.managedObjectContext)
        let rara = Contact(dictionary: raraDictionary, context: coreDataStack.managedObjectContext)
        let aninda = Contact(dictionary: anindaDictionary, context: coreDataStack.managedObjectContext)
        
        print(putra.firstName! + " " + aninda.firstName! + " " + rara.firstName!)
        
        coreDataStack.saveContext()
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        preloadData()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
        coreDataStack.saveContext()
    }

    

}

