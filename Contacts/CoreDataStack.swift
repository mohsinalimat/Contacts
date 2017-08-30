//
//  CoreDataStack.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/30/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    
    // MARK: Change this if xcdatamodel filename changed
    private static let moduleName = "ContactsDataModel"
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        if let modelURL = Bundle.main.url(forResource: moduleName, withExtension: "momd") {
            guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
                fatalError("the \(modelURL) doesn't contains any managedObjectModel file")
            }
            return model
        } else {
            fatalError("Can't find model file with name \(moduleName) in bundle")
        }
    }()
    
    lazy var applicationdocumentDirectory: URL = {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Can't find the directory")
        }
        return directory
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let persistentStoreURL = self.applicationdocumentDirectory.appendingPathComponent("\(moduleName).sqlite")
        
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: options)
        } catch let error as NSError {
            fatalError("Persistent store error: \(error)")
        }
        
        return coordinator
    }()
    
    lazy var manageObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        return context
    }()
    
    func saveMainContext() {
        if manageObjectContext.hasChanges {
            do {
                try manageObjectContext.save()
            } catch let error as NSError {
                fatalError("Error saving managedobject context! \(error)")
            }
        }
    }
    
}
