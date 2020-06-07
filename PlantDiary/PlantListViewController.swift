//
//  PlantListViewController.swift
//  PlantDiary
//
//  Created by Matthew Hallatt on 02/06/2020.
//  Copyright © 2020 Matthew Hallatt. All rights reserved.
//

import CoreData
import UIKit

class PlantListViewController: UIViewController {
    
    enum SegueIdentifier: String {
        case showPlantDetails = "ShowPlantDetails"
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newPlantButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    private var context: NSManagedObjectContext!
    private lazy var fetchedResultsController = Plant.defaultFetchedResultsController(in: context)
    private var plants: [Plant] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        DataStore().loadPersistentStores { container in
            self.context = container.newBackgroundContext()
            self.setupFetchedResultsController()
        }
    }
    
    // MARK: - Setup
    
    private func setupFetchedResultsController() {
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            plants = fetchedResultsController.fetchedObjects ?? []
        } catch {
            print("Error fetching plants: \(error)")
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newPlantViewController = segue.destination as? NewPlantViewController {
            newPlantViewController.context = context
        }
        
        if let plantDetailViewController = segue.destination as? PlantDetailViewController,
            let selectedIndexPath = tableView.indexPathForSelectedRow,
            selectedIndexPath.row < plants.count {
            let selectedPlant = plants[selectedIndexPath.row]
            plantDetailViewController.plant = selectedPlant
            plantDetailViewController.context = context
            tableView.deselectRow(at: selectedIndexPath, animated: false)
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension PlantListViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let newPlants = controller.fetchedObjects as? [Plant] else {
            return
        }
        
        plants = newPlants
    }
}

// MARK: - Data Source

extension PlantListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlantListTableViewCell.reuseIdentifier, for: indexPath) as! PlantListTableViewCell
        let plant = plants[indexPath.row]
        
        cell.populate(with: plant)
        
        return cell
    }
}

// MARK: - Delegate

extension PlantListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.showPlantDetails.rawValue, sender: self)
    }
}
