//
//  Creatures.swift
//  Catch Em All
//
//  Created by Korlin Favara on 1/17/22.
//

import Foundation

struct CreaturesParsed {
    var count: Int
    var next: String?
    var name: String
}

class Creatures {
    
    private struct Returned: Codable {
        var count: Int
        var next: String?
        var results: [Creature]
    }
    
    struct Creature: Codable {
        var name = ""
        var url = ""
    }
    
    var count = 0
    var urlString = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20"
    var creatureArray: [Creature] = []
    
    
    func getData(completed : @escaping () -> ()) {
        print("We are accessing url from \(urlString)")
        
        // Create url
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create url from \(self.urlString)")
            // completed()
            return
        }
        
        // Create Session
        let session = URLSession.shared
        
        // Get data with .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                print("Here is what was returned \(returned)")
                self.creatureArray = self.creatureArray + returned.results
                self.urlString = returned.next ?? ""
                self.count = returned.count
            } catch {
                print("JSON ERROR: Thrown when we tried to decode for Returned.self")
            }
            completed()
        }
        task.resume()
    }
}
