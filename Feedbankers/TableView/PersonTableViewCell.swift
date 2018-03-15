//
//  PersonTableViewCell.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 14/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit
import ChameleonFramework

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var personImage: CircularImage!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personDetails: UILabel!
    
    fileprivate let ACTUAL_COLOR = UIColor.white.withAlphaComponent(0)
    fileprivate let PLACEHOLDER_COLOR = UIColor.flatWhiteDark
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func clearCell() {
        personName.backgroundColor = PLACEHOLDER_COLOR
        personName.text = ""
        personDetails.backgroundColor = PLACEHOLDER_COLOR
        personDetails.text = ""
    }
    
    func updateCell(imageURL : String?, name : String, details : String) {
        personName.backgroundColor = ACTUAL_COLOR
        personDetails.backgroundColor = ACTUAL_COLOR
        
        personImage.image = #imageLiteral(resourceName: "userBlue")
        if let urlString = imageURL {
            if let url = URL(string: urlString) {
                personImage.kf.setImage(with: url)
            }
        }
        personName.text = name
        personDetails.text = details
    }
}
