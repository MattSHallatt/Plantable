//
//  ShootStage.swift
//  PlantDiary
//
//  Created by Matthew Hallatt on 06/06/2020.
//  Copyright © 2020 Matthew Hallatt. All rights reserved.
//

import CoreData

final class ShootStage: NSManagedObject {
    @NSManaged fileprivate(set) var shootDate: Date
    
    @discardableResult
    static func create(
        in context: NSManagedObjectContext,
        at shootDate: Date
    ) -> ShootStage {
        let entityName = "ShootStage"
        
        guard let object = NSEntityDescription.insertNewObject(
            forEntityName: entityName,
            into: context) as? ShootStage else {
                fatalError("Failed to create ShootStage")
        }
        
        object.shootDate = shootDate
        
        return object
    }
}

extension ShootStage: Stage {
    var stageStartDate: Date {
        return shootDate
    }
}
