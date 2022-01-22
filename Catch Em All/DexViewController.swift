//
//  DexViewController.swift
//  Catch Em All
//
//  Created by Korlin Favara on 1/19/22.
//

import UIKit

class DexViewController: UIViewController {
    
    @IBOutlet weak var dexTableView: UITableView!
    @IBOutlet weak var loadAllButton: UIBarButtonItem!
    
    
    
    var pokeRegions: [String] = ["Kanto",
                                 "Jhoto",
                                 "Hoen",
                                 "Sinnoh",
                                 "Unova",
                                 "Kalos",
                                 "Alola",
                                 "Galar"]
    //                                 "Other"]
    
    var creatures = Creatures()
    var activityIndicator = UIActivityIndicatorView()
    var dexURLLow: String!
    var dexURLHigh: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dexTableView.delegate = self
        dexTableView.dataSource = self
        
        // improving tableView
        dexTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func loadAll() {
        if creatures.urlString.hasPrefix("http") {
            creatures.getData {
                self.loadAll()
            }
        } else {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
    func setUpActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.red
        view.addSubview(activityIndicator)
    }
    
    @IBAction func loadAllPressed(_ sender: UIBarButtonItem) {
        creatures.urlString = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20"
        creatures.creatureArray = []
        setUpActivityIndicator()
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        loadAll()
    }
}


extension DexViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeRegions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath) as! DexTableViewCell
        cell.dexLabel?.text = pokeRegions[indexPath.row]
        
        // round cell
        cell.dexView.layer.cornerRadius = cell.dexView.frame.height / 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDex = pokeRegions[indexPath.row]
        
        if selectedDex == "Kanto" {
            dexURLLow = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20"
            dexURLHigh = "https://pokeapi.co/api/v2/pokemon/?offset=160&limit=20"
            
        } else if selectedDex == "Jhoto" {
            dexURLLow = "https://pokeapi.co/api/v2/pokemon/?offset=140&limit=20"
            dexURLHigh = "https://pokeapi.co/api/v2/pokemon/?offset=260&limit=20"

        } else if selectedDex == "Hoen" {
            dexURLLow = "https://pokeapi.co/api/v2/pokemon/?offset=240&limit=20"
            dexURLHigh = "https://pokeapi.co/api/v2/pokemon/?offset=400&limit=20"
            
        } else if selectedDex == "Sinnoh" {
            dexURLLow = "https://pokeapi.co/api/v2/pokemon/?offset=380&limit=20"
            dexURLHigh = "https://pokeapi.co/api/v2/pokemon/?offset=500&limit=20"
            
        } else if selectedDex == "Unova" {
            dexURLLow = "https://pokeapi.co/api/v2/pokemon/?offset=480&limit=20"
            dexURLHigh = "https://pokeapi.co/api/v2/pokemon/?offset=660&limit=20"
            
        } else if selectedDex == "Kalos" {
            dexURLLow = "https://pokeapi.co/api/v2/pokemon/?offset=640&limit=20"
            dexURLHigh = "https://pokeapi.co/api/v2/pokemon/?offset=740&limit=20"
            
        } else if selectedDex == "Alola" {
            dexURLLow = "https://pokeapi.co/api/v2/pokemon/?offset=720&limit=20"
            dexURLHigh = "https://pokeapi.co/api/v2/pokemon/?offset=820&limit=20"
            
        } else if selectedDex == "Galar" {
            dexURLLow = "https://pokeapi.co/api/v2/pokemon/?offset=800&limit=20"
            dexURLHigh = "https://pokeapi.co/api/v2/pokemon/?offset=920&limit=20"
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(identifier: "ListViewController") as? ListViewController {
            navigationController?.pushViewController(viewController, animated: true)
            viewController.creatures.creatureArray = creatures.creatureArray
            viewController.dexURLLow = dexURLLow
            viewController.dexURLHigh = dexURLHigh
            viewController.selectedDex = selectedDex
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
