//
//  NewPlantViewController.swift
//  PlantDiary
//
//  Created by Matthew Hallatt on 02/06/2020.
//  Copyright © 2020 Matthew Hallatt. All rights reserved.
//

import CoreData
import UIKit

class NewPlantViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var latinNameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!

    // MARK: - Properties
    
    var context: NSManagedObjectContext!

    // MARK: - Computed Properties
    
    var plantName: String? {
        if let name = nameTextField.text, !name.isEmpty {
            return name
        } else {
            return nil
        }
    }
    
    var plantNickname: String? {
        if let nickname = nicknameTextField.text, !nickname.isEmpty {
            return nickname
        } else {
            return nil
        }
    }
    
    var plantLatinName: String? {
        if let latinName = latinNameTextField.text, !latinName.isEmpty {
            return latinName
        } else {
            return nil
        }
    }

    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.becomeFirstResponder()
    }

    // MARK: - IBActions
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewPlant() {
        guard let plantName = plantName else {
            return
        }
        
        Plant.create(
            in: context,
            called: plantName,
            withLatin: plantLatinName,
            nickname: plantNickname
        )
        
        do {
            try context.save()
            dismiss(animated: true, completion: nil)
        } catch {
            print("Error adding new plant: \(error)")
        }
    }
}

// MARK: - UITextFieldDelegate

extension NewPlantViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            nicknameTextField.becomeFirstResponder()
        case nicknameTextField:
            latinNameTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return false
    }
}
