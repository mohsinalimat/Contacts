//
//  CoreDataStack.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/30/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import CoreData

struct CoreDataStack {
    
    private let managedObjectModel: NSManagedObjectModel
    internal let persistentStoreCoordinator: NSPersistentStoreCoordinator
    private let managedObjectModelURL: URL
    internal let databaseURL: URL
    internal let persistingManagedObjectContext: NSManagedObjectContext
    internal let backgroundManagedObjectContext: NSManagedObjectContext
    let managedObjectContext: NSManagedObjectContext
    
    init(completion: (() -> ())?) {
        //This resource is the same name as your xcdatamodeld contained in your project
        guard let managedObjectModelURL = Bundle.main.url(forResource: "Contacts", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        self.managedObjectModelURL = managedObjectModelURL
        
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: managedObjectModelURL) else {
            fatalError("Error initializing mom from: \(managedObjectModelURL)")
        }
        
        self.managedObjectModel = managedObjectModel
        
        // Create the store coordinator and its context
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        // Create a persistingContext (private queue) and a child one (main queue)
        // Create a context and add connect it to the coordinator
        persistingManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        persistingManagedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = persistingManagedObjectContext
        
        // Create a background context child of main context
        backgroundManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundManagedObjectContext.parent = managedObjectContext
        
        self.persistentStoreCoordinator = persistentStoreCoordinator
        
        // Add a SQLite store located in the documents folder
        guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        let storeURL = docURL.appendingPathComponent("DataModel.sqlite")
        
        self.databaseURL = storeURL
        
        // Options for migration
        let options = [NSInferMappingModelAutomaticallyOption: true,NSMigratePersistentStoresAutomaticallyOption: true]
        
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        queue.async {
            
            do {
                try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options as [NSObject : AnyObject])
                //The callback block is expected to complete the User Interface and therefore should be presented back on the main queue so that the user interface does not need to be concerned with which queue this call is coming from.
                DispatchQueue.main.sync(execute: completion!)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    
    
}

// MARK: - CoreDataStack (Removing Data)

internal extension CoreDataStack  {
    
    func dropAllData() throws {
        let options = [NSInferMappingModelAutomaticallyOption: true, NSMigratePersistentStoresAutomaticallyOption: true]
        try persistentStoreCoordinator.destroyPersistentStore(at: databaseURL, ofType: NSSQLiteStoreType , options: nil)
        try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: databaseURL, options: options as [NSObject : AnyObject])
    }
}

// MARK: - CoreDataStack (Batch Processing in the Background)

extension CoreDataStack {
    
    func performBackgroundBatchOperation(_ batch: @escaping (_ workerContext: NSManagedObjectContext) -> (Void)) {
        
        backgroundManagedObjectContext.perform() {
            
            batch(self.backgroundManagedObjectContext)
            
            // Save it to the parent context, so normal saving
            // can work
            do {
                try self.backgroundManagedObjectContext.save()
            } catch {
                fatalError("Error while saving backgroundContext: \(error)")
            }
        }
    }
}

// MARK: - CoreDataStack (Save Data)

extension CoreDataStack {
    
    func save() {
        // We call this synchronously, but it's a very fast
        // operation (it doesn't hit the disk). We need to know
        // when it ends so we can call the next save (on the persisting
        // context). This last one might take some time and is done
        // in a background queue
        managedObjectContext.performAndWait() {
            
            if self.managedObjectContext.hasChanges {
                do {
                    try self.managedObjectContext.save()
                } catch {
                    fatalError("Error while saving main context: \(error)")
                }
                
                // save in the background
                self.persistingManagedObjectContext.perform() {
                    do {
                        try self.persistingManagedObjectContext.save()
                    } catch {
                        fatalError("Error while saving persisting context: \(error)")
                    }
                }
            }
        }
    }
    
    func autoSave(_ delayInSeconds : Int) {
        
        if delayInSeconds > 0 {
            do {
                try self.managedObjectContext.save()
                print("Autosaving")
            } catch {
                print("Error while autosaving")
            }
            
            let delayInNanoSeconds = UInt64(delayInSeconds) * NSEC_PER_SEC
            let time = DispatchTime.now() + Double(Int64(delayInNanoSeconds)) / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.autoSave(delayInSeconds)
            }
        }
    }
}
