//
//  PlantedStage.swift
//  PlantDiary
//
//  Created by Matthew Hallatt on 06/06/2020.
//  Copyright © 2020 Matthew Hallatt. All rights reserved.
//

import CoreData

final class PlantedStage: NSManagedObject {
    @NSManaged fileprivate(set) var plantedDate: Date
    
    @discardableResult
    static func create(
        in context: NSManagedObjectContext,
        at plantedDate: Date
    ) -> PlantedStage {
        let entityName = "PlantedStage"
        
        guard let object = NSEntityDescription.insertNewObject(
            forEntityName: entityName,
            into: context) as? PlantedStage else {
                fatalError("Failed to create PlantedStage")
        }
        
        object.plantedDate = plantedDate
        
        return object
    }
}

extension PlantedStage: Stage {
    var stageStartDate: Date {
        return plantedDate
    }
}
