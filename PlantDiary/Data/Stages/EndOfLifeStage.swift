//
//  EndOfLifeStage.swift
//  PlantDiary
//
//  Created by Matthew Hallatt on 06/06/2020.
//  Copyright © 2020 Matthew Hallatt. All rights reserved.
//

import CoreData

final class EndOfLifeStage: NSManagedObject {
    @NSManaged fileprivate(set) var endOfLifeDate: Date
    
    @discardableResult
    static func create(
        in context: NSManagedObjectContext,
        at endOfLifeDate: Date
    ) -> EndOfLifeStage {
        let entityName = "EndOfLifeStage"
        
        guard let object = NSEntityDescription.insertNewObject(
            forEntityName: entityName,
            into: context) as? EndOfLifeStage else {
                fatalError("Failed to create EndOfLifeStage")
        }
        
        object.endOfLifeDate = endOfLifeDate
        
        return object
    }
}

extension EndOfLifeStage: Stage {
    var stageStartDate: Date {
        return endOfLifeDate
    }
}
