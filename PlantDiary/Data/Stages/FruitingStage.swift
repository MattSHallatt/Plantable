//
//  FruitingStage.swift
//  PlantDiary
//
//  Created by Matthew Hallatt on 06/06/2020.
//  Copyright © 2020 Matthew Hallatt. All rights reserved.
//

import CoreData

final class FruitingStage: NSManagedObject {
    @NSManaged fileprivate(set) var fruitingDate: Date
    
    @discardableResult
    static func create(
        in context: NSManagedObjectContext,
        at fruitingDate: Date
    ) -> FruitingStage {
        let entityName = "FruitingStage"
        
        guard let object = NSEntityDescription.insertNewObject(
            forEntityName: entityName,
            into: context) as? FruitingStage else {
                fatalError("Failed to create FruitingStage")
        }
        
        object.fruitingDate = fruitingDate
        
        return object
    }
}

extension FruitingStage: Stage {
    var stageStartDate: Date {
        return fruitingDate
    }
}
