//
//  Plant.swift
//  PlantDiary
//
//  Created by Matthew Hallatt on 04/06/2020.
//  Copyright © 2020 Matthew Hallatt. All rights reserved.
//

import CoreData

enum PlantStage {
    case planted
    case shoot
    case budding
    case flowering
    case fruiting
    case endOfLife
}

final class Plant: NSManagedObject {
    @NSManaged fileprivate(set) var dateAdded: Date
    @NSManaged fileprivate(set) var name: String
    @NSManaged fileprivate(set) var latinName: String?
    @NSManaged fileprivate(set) var nickname: String?
    
    @NSManaged fileprivate(set) var plantedStage: PlantedStage?
    @NSManaged fileprivate(set) var shootStage: ShootStage?
    @NSManaged fileprivate(set) var buddingStage: BuddingStage?
    @NSManaged fileprivate(set) var floweringStage: FloweringStage?
    @NSManaged fileprivate(set) var fruitingStage: FruitingStage?
    @NSManaged fileprivate(set) var endOfLifeStage: EndOfLifeStage?
    
    var nextStage: PlantStage? {
        if plantedStage == nil {
            return .planted
        } else if shootStage == nil {
            return .shoot
        } else if buddingStage == nil {
            return .budding
        } else if floweringStage == nil {
            return .flowering
        } else if fruitingStage == nil {
            return .fruiting
        } else if endOfLifeStage == nil {
            return .endOfLife
        } else {
            return nil
        }
    }
    
    @discardableResult
    static func create(
        in context: NSManagedObjectContext,
        called name: String,
        withLatin latinName: String?,
        nickname: String?
    ) -> Plant {
        let entityName = "Plant"
        
        guard let object = NSEntityDescription.insertNewObject(
            forEntityName: entityName,
            into: context) as? Plant else {
                fatalError("Failed to create Plant")
        }
        
        object.dateAdded = Date()
        object.name = name
        object.latinName = latinName
        object.nickname = nickname
        
        return object
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "dateAdded", ascending: false),
            NSSortDescriptor(key: "name", ascending: true)
        ]
    }
    
    static var defaultFetchRequest: NSFetchRequest<Plant> {
        let fetchRequest = NSFetchRequest<Plant>(entityName: entity().name!)
        fetchRequest.sortDescriptors = defaultSortDescriptors
        return fetchRequest
    }
    
    static func defaultFetchedResultsController(in context: NSManagedObjectContext) -> NSFetchedResultsController<Plant> {
        return NSFetchedResultsController<Plant>(
            fetchRequest: defaultFetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }
    
    func planted(
        on plantedDate: Date,
        in context: NSManagedObjectContext
    ) {
        plantedStage = PlantedStage.create(in: context, at: plantedDate)
    }
    
    func shooting(
        on shootDate: Date,
        in context: NSManagedObjectContext
    ) {
        shootStage = ShootStage.create(in: context, at: shootDate)
    }
    
    func budding(
        on buddingDate: Date,
        in context: NSManagedObjectContext
    ) {
        buddingStage = BuddingStage.create(in: context, at: buddingDate)
    }
    
    func flowering(
        on floweringDate: Date,
        in context: NSManagedObjectContext
    ) {
        floweringStage = FloweringStage.create(in: context, at: floweringDate)
    }
    
    func fruiting(
        on fruitingDate: Date,
        in context: NSManagedObjectContext
    ) {
        fruitingStage = FruitingStage.create(in: context, at: fruitingDate)
    }
    
    func endOfLife(
        on endOfLifeDate: Date,
        in context: NSManagedObjectContext
    ) {
        endOfLifeStage = EndOfLifeStage.create(in: context, at: endOfLifeDate)
    }
}
