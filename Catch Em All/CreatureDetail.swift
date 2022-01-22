//
//  CreatureDetail.swift
//  Catch Em All
//
//  Created by Korlin Favara on 1/19/22.
//

import Foundation

class CreatureDetail {
    
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprites!
    }
    
    private struct Sprites: Codable {
        var front_shiny: String
        var other: Other!
    }

    private struct Other: Codable {
        var home: Home
    }

    private struct Home: Codable {
        var front_default: String
        var front_shiny: String
    }
    
    var height = 0.0
    var weight = 0.0
    var imageURL = ""
    var ogImageShinyURL = ""
    var imageShinyURL = ""
    var urlString = ""
    
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
//                self.creatureArray = self.creatureArray + returned.results
//                self.urlString = returned.next ?? ""
//                self.count = returned.count
                self.height = returned.height
                self.weight = returned.weight
                self.imageURL = returned.sprites.other.home.front_default
                self.imageShinyURL = returned.sprites.other.home.front_shiny
                self.ogImageShinyURL = returned.sprites.front_shiny
            } catch {
                print("JSON ERROR: Thrown when we tried to decode for Returned.self")
            }
            completed()
        }
        task.resume()
    }
}
