//
//  BuddingStage.swift
//  PlantDiary
//
//  Created by Matthew Hallatt on 06/06/2020.
//  Copyright © 2020 Matthew Hallatt. All rights reserved.
//

import CoreData

final class BuddingStage: NSManagedObject {
    @NSManaged fileprivate(set) var buddingDate: Date
    
    @discardableResult
    static func create(
        in context: NSManagedObjectContext,
        at buddingDate: Date
    ) -> BuddingStage {
        let entityName = "BuddingStage"
        
        guard let object = NSEntityDescription.insertNewObject(
            forEntityName: entityName,
            into: context) as? BuddingStage else {
                fatalError("Failed to create BuddingStage")
        }
        
        object.buddingDate = buddingDate
        
        return object
    }
}

extension BuddingStage: Stage {
    var stageStartDate: Date {
        return buddingDate
    }
}
