//
//  GACoreDataModel.swift
//  GraphyAssignment
//
//  Created by Balaji S on 08/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit
import CoreData

class GACoreDataModel: NSObject {

    override init()
    {
        super.init()

        NotificationCenter.default.addObserver(self, selector: #selector(GACoreDataModel.contextDidSaveContext(_:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)
    }


    @objc static var sharedDataModel = GACoreDataModel()

    // MARK: - Core Data stack

    @objc lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "ClearTrip.CTCoreDataModel" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    @objc lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "GraphyAssignment", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    @objc lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("GraphyAssignment.sqlite")
        print("url: \(url)")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: Any]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

//            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            print("Error : \(error) ")
        }

        return coordinator
    }()

    @objc lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()


    @objc lazy var privateManagedContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var privateManagedContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateManagedContext.persistentStoreCoordinator = coordinator
        return privateManagedContext
    }()

    // MARK: - Core Data Saving support

    @objc func saveContext (_ context: NSManagedObjectContext) {

        if (self.persistentStoreCoordinator.persistentStores.count == 0) {
            return
        }

        var error: NSError? = nil
        if context.hasChanges {
            do {
                try context.save()
            } catch let error1 as NSError {
                error = error1
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(String(describing: error)), \(error!.userInfo)")
            }
        }
    }

    @objc func saveContext () {
        self.saveContext( self.privateManagedContext )
    }


    @objc func contextDidSaveContext(_ notification: Notification)
    {
        let sender = notification.object as! NSManagedObjectContext
        if sender === self.managedObjectContext {
            NSLog("******** Saved main Context in this thread")
            self.privateManagedContext.perform {
                self.privateManagedContext.mergeChanges(fromContextDidSave: notification)
            }
        } else if sender === self.privateManagedContext {
            NSLog("******** Saved background Context in this thread")
            self.managedObjectContext.perform {
                self.managedObjectContext.mergeChanges(fromContextDidSave: notification)
            }
        } else {
            NSLog("******** Saved Context in other thread")
            self.privateManagedContext.perform {
                self.privateManagedContext.mergeChanges(fromContextDidSave: notification)
            }
            self.managedObjectContext.perform {
                self.managedObjectContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
