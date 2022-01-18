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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        creatures.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.creatures.creatureArray.count) of \(self.creatures.count) pokemon"
            }
        }
    }
    func loadAll() {
        if creatures.urlString.hasPrefix("http") {
            creatures.getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "\(self.creatures.creatureArray.count) of \(self.creatures.count) pokemon"
                    self.tableView.reloadData()
                }
                self.loadAll()
            }
        }
    }
    
    @IBAction func loadAllButtonPressed(_ sender: UIBarButtonItem) {
        loadAll()
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.row == creatures.creatureArray.count-1 && creatures.urlString.hasPrefix("http") {
            creatures.getData {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.navigationItem.title = "\(self.creatures.creatureArray.count) of \(self.creatures.count) pokemon"
                }
            }
        }
            cell.textLabel?.text = "\(indexPath.row+1). \(self.creatures.creatureArray[indexPath.row].name)"
            return cell
        }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creatures.creatureArray.count
    }
    
}
