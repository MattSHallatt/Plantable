//
//  DataStore.swift
//  PlantDiary
//
//  Created by Matthew Hallatt on 04/06/2020.
//  Copyright © 2020 Matthew Hallatt. All rights reserved.
//

import CoreData

class DataStore {
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return container.newBackgroundContext()
    }
    
    func newChildViewContext() -> NSManagedObjectContext {
        return newChildContext(for: viewContext)
    }
    
    func newChildContext(for context: NSManagedObjectContext) -> NSManagedObjectContext {
        let childContext = NSManagedObjectContext(concurrencyType: context.concurrencyType)
        childContext.parent = context
        return childContext
    }
    
    let container = NSPersistentContainer(name: "PlantModel")
    
    func loadPersistentStores(_ handler: @escaping (NSPersistentContainer) -> ()) {
        container.loadPersistentStores { (description, error) in
            guard error == nil else {
                fatalError("Failed to load persistent store")
            }
            
            DispatchQueue.main.async { handler(self.container) }
        }
    }
    
}
