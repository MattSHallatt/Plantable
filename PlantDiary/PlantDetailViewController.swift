//
//  PlantDetailViewController.swift
//  PlantDiary
//
//  Created by Matthew Hallatt on 02/06/2020.
//  Copyright © 2020 Matthew Hallatt. All rights reserved.
//

import CoreData
import UIKit

class PlantDetailViewController: UIViewController {

    // MARK: - Static Properties
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        return formatter
    }()

    // MARK: - IBOutlets
    
    @IBOutlet weak var plantNicknameLabel: UILabel!
    @IBOutlet weak var plantLatinNameLabel: UILabel!
    @IBOutlet weak var stagesStackView: UIStackView!
    @IBOutlet weak var plantedStageButton: UIButton!
    @IBOutlet weak var shootingStageButton: UIButton!
    @IBOutlet weak var buddingStageButton: UIButton!
    @IBOutlet weak var floweringStageButton: UIButton!
    @IBOutlet weak var fruitingStageButton: UIButton!
    @IBOutlet weak var endOfLifeStageButton: UIButton!

    // MARK: - Computed
    
    var buttons: [UIButton] {
        return [
            plantedStageButton,
            shootingStageButton,
            buddingStageButton,
            floweringStageButton,
            fruitingStageButton,
            endOfLifeStageButton
        ]
    }

    // MARK: - Properties
    
    var context: NSManagedObjectContext!
    var plant: Plant!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = plant.name
        plantNicknameLabel.text = "\"\(plant.nickname ?? "")\""
        plantLatinNameLabel.text = plant.latinName
        
        updateItemVisibilities()
        updateStages()
        styleButtons()
    }

    // MARK: - Updating
    
    func updateItemVisibilities() {
        plantNicknameLabel.isHidden = plant.nickname == nil
        plantLatinNameLabel.isHidden = plant.latinName == nil
        plantedStageButton.isHidden = plant.nextStage != .planted
        shootingStageButton.isHidden = plant.nextStage != .shoot
        buddingStageButton.isHidden = plant.nextStage != .budding
        floweringStageButton.isHidden = plant.nextStage != .flowering
        fruitingStageButton.isHidden = plant.nextStage != .fruiting
        endOfLifeStageButton.isHidden = plant.nextStage != .endOfLife
    }
    
    private func styleButtons() {
        for button in buttons {
            button.layer.cornerRadius = 12
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
    
    func updateStages() {
        stagesStackView.subviews.forEach { $0.removeFromSuperview() }
        
        if let plantedStage = plant.plantedStage {
            let label = UILabel()
            label.text = "Planted: \(Self.dateFormatter.string(from: plantedStage.stageStartDate))"
            stagesStackView.addArrangedSubview(label)
        }
        
        if let shootStage = plant.shootStage {
            let label = UILabel()
            label.text = "Shooting: \(Self.dateFormatter.string(from: shootStage.stageStartDate))"
            stagesStackView.addArrangedSubview(label)
        }
        
        if let buddingStage = plant.buddingStage {
            let label = UILabel()
            label.text = "Budding: \(Self.dateFormatter.string(from: buddingStage.stageStartDate))"
            stagesStackView.addArrangedSubview(label)
        }
        
        if let floweringStage = plant.floweringStage {
            let label = UILabel()
            label.text = "Flowering: \(Self.dateFormatter.string(from: floweringStage.stageStartDate))"
            stagesStackView.addArrangedSubview(label)
        }
        
        if let fruitingStage = plant.fruitingStage {
            let label = UILabel()
            label.text = "Fruiting: \(Self.dateFormatter.string(from: fruitingStage.stageStartDate))"
            stagesStackView.addArrangedSubview(label)
        }
        
        if let endOfLifeStage = plant.endOfLifeStage {
            let label = UILabel()
            label.text = "End Of Life: \(Self.dateFormatter.string(from: endOfLifeStage.stageStartDate))"
            stagesStackView.addArrangedSubview(label)
        }
    }

    // MARK: - IBActions
    
    @IBAction func upgradeToPlanted() {
        plant.planted(on: Date(), in: context)
        
        do {
            try context.save()
            updateItemVisibilities()
            updateStages()
        } catch {
            print("Error planting plant: \(plant.name)")
        }
    }
    
    @IBAction func upgradeToShooting() {
        plant.shooting(on: Date(), in: context)
        
        do {
            try context.save()
            updateItemVisibilities()
            updateStages()
        } catch {
            print("Error shooting plant: \(plant.name)")
        }
    }
    
    @IBAction func upgradeToBudding() {
        plant.budding(on: Date(), in: context)
        
        do {
            try context.save()
            updateItemVisibilities()
            updateStages()
        } catch {
            print("Error budding plant: \(plant.name)")
        }
    }
    
    @IBAction func upgradeToFlowering() {
        plant.flowering(on: Date(), in: context)
        
        do {
            try context.save()
            updateItemVisibilities()
            updateStages()
        } catch {
            print("Error flowering plant: \(plant.name)")
        }
    }
    
    @IBAction func upgradeToFruiting() {
        plant.fruiting(on: Date(), in: context)
        
        do {
            try context.save()
            updateItemVisibilities()
            updateStages()
        } catch {
            print("Error fruiting plant: \(plant.name)")
        }
    }
    
    @IBAction func upgradeToEndOfLife() {
        plant.endOfLife(on: Date(), in: context)
        
        do {
            try context.save()
            updateItemVisibilities()
            updateStages()
        } catch {
            print("Error ending life of plant: \(plant.name)")
        }
    }
}
