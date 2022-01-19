//
//  UpdatedTableViewCell.swift
//  Catch Em All
//
//  Created by Korlin Favara on 1/19/22.
//

import UIKit

class UpdatedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonView: UIView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonShinyImageView: UIImageView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
