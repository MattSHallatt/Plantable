//
//  PlantListTableViewCell.swift
//  PlantDiary
//
//  Created by Matthew Hallatt on 02/06/2020.
//  Copyright © 2020 Matthew Hallatt. All rights reserved.
//

import UIKit

class PlantListTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        return formatter
    }()
    
    static let reuseIdentifier = "PlantListTableViewCellReuseIdentifier"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var iconStackView: UIStackView!
    @IBOutlet weak var plantIconImageView: UIImageView!
    @IBOutlet weak var shootIconImageView: UIImageView!
    @IBOutlet weak var budIconImageView: UIImageView!
    @IBOutlet weak var flowerIconImageView: UIImageView!
    @IBOutlet weak var fruitIconImageView: UIImageView!
    @IBOutlet weak var endOfLifeIconImageView: UIImageView!
    
    // MARK: - Properties
    
    var hasSetupConstraints: Bool = false
    
    // MARK: - Initialisers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    
    private func setupConstraints() {
        guard !hasSetupConstraints else {
            return
        }
        
        hasSetupConstraints = true
        
        NSLayoutConstraint.activate([
            iconStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            iconStackView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -50),
        ])
    }
    
    // MARK: - Population
    
    func populate(with plant: Plant) {
        accessoryType = .disclosureIndicator
        textLabel?.text = plant.name
        
        var subtitle = ""
        
        if let plantNickname = plant.nickname {
            subtitle.append("\"\(plantNickname)\" ")
        }
        
        if let plantedStage = plant.plantedStage {
            let plantedDate = PlantListTableViewCell.dateFormatter.string(from: plantedStage.plantedDate)
            subtitle.append("Planted on \(plantedDate)")
        }
        
        update(icon: plantIconImageView, for: plant.plantedStage)
        update(icon: shootIconImageView, for: plant.shootStage)
        update(icon: budIconImageView, for: plant.buddingStage)
        update(icon: flowerIconImageView, for: plant.floweringStage)
        update(icon: fruitIconImageView, for: plant.fruitingStage)
        update(icon: endOfLifeIconImageView, for: plant.endOfLifeStage)
        
        detailTextLabel?.textColor = .systemGray
        detailTextLabel?.text = subtitle
        
        setupConstraints()
    }
    
    private func update(icon: UIImageView, for stage: Stage?) {
        if stage == nil {
            icon.tintColor = UIColor.systemFill
        } else {
            icon.tintColor = UIColor.systemBlue
        }
    }
}
