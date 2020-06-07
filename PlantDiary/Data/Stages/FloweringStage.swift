//
//  FloweringStage.swift
//  PlantDiary
//
//  Created by Matthew Hallatt on 06/06/2020.
//  Copyright © 2020 Matthew Hallatt. All rights reserved.
//

import CoreData

final class FloweringStage: NSManagedObject {
    @NSManaged fileprivate(set) var floweringDate: Date
    
    @discardableResult
    static func create(
        in context: NSManagedObjectContext,
        at floweringDate: Date
    ) -> FloweringStage {
        let entityName = "FloweringStage"
        
        guard let object = NSEntityDescription.insertNewObject(
            forEntityName: entityName,
            into: context) as? FloweringStage else {
                fatalError("Failed to create FloweringStage")
        }
        
        object.floweringDate = floweringDate
        
        return object
    }
}

extension FloweringStage: Stage {
    var stageStartDate: Date {
        return floweringDate
    }
}
