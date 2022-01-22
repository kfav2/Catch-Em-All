//
//  ListViewController.swift
//  Catch Em All
//
//  Created by Korlin Favara on 1/17/22.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var creatures = Creatures()
    var activityIndicator = UIActivityIndicatorView()
    var creature: Creature!
    var imageArray: [String] = []
    var dexURLLow: String!
    var dexURLHigh: String!
    var selectedDex: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        // improving tableView
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        creatures.urlString = dexURLLow
        loadDex()
    }
    
    
    
    
    func setUpActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.red
        view.addSubview(activityIndicator)
    }
    
    func loadDex() {
        
        if creatures.urlString == dexURLHigh {
            if self.selectedDex == "Kanto" {
                self.creatures.creatureArray.removeSubrange(151...self.creatures.creatureArray.count-1)
                
            } else if self.selectedDex == "Jhoto" {
                self.creatures.creatureArray.removeSubrange(111...self.creatures.creatureArray.count-1)
                self.creatures.creatureArray.removeSubrange(0...10)
                
            } else if self.selectedDex == "Hoen" {
                self.creatures.creatureArray.removeSubrange(145...self.creatures.creatureArray.count-1)
                self.creatures.creatureArray.removeSubrange(0...10)
                
            } else if self.selectedDex == "Sinnoh" {
                self.creatures.creatureArray.removeSubrange(112...self.creatures.creatureArray.count-1)
                self.creatures.creatureArray.removeSubrange(0...5)
                
            } else if self.selectedDex == "Unova" {
                self.creatures.creatureArray.removeSubrange(169...self.creatures.creatureArray.count-1)
                self.creatures.creatureArray.removeSubrange(0...12)
                
            } else if self.selectedDex == "Kalos" {
                self.creatures.creatureArray.removeSubrange(81...self.creatures.creatureArray.count-1)
                self.creatures.creatureArray.removeSubrange(0...8)
                
            } else if self.selectedDex == "Alola" {
                self.creatures.creatureArray.removeSubrange(87...self.creatures.creatureArray.count-1)
                self.creatures.creatureArray.removeFirst()
                
            } else if self.selectedDex == "Galar" {
                self.creatures.creatureArray.removeSubrange(98...self.creatures.creatureArray.count-1)
                self.creatures.creatureArray.removeSubrange(0...8)
            }
            
            DispatchQueue.main.async {
                self.navigationItem.title = "\(self.selectedDex!): \(self.creatures.creatureArray.count) pokemon"
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
        } else {
            creatures.getData {
                self.loadDex()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.creature = creatures.creatureArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true )
            }
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
        
        
        
        let creatureDetails = CreatureDetail()
        creatureDetails.urlString = self.creatures.creatureArray[indexPath.row].url
        
        creatureDetails.getData {
            DispatchQueue.main.async {
                guard let url = URL(string: creatureDetails.ogImageShinyURL) else {return}
                do {
                    let data = try Data(contentsOf: url)
                    cell.pokemonShinyImageView.image = UIImage(data: data)
                } catch {
                    print("ERROR: thrown trying to get image from url \(url)")
                }
            }
        }
        
        cell.pokemonNameLabel.text = "\(indexPath.row+1). \(self.creatures.creatureArray[indexPath.row].name)"
        
        // round cell
        cell.pokemonView.layer.cornerRadius = cell.pokemonView.frame.height / 2
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creatures.creatureArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}
