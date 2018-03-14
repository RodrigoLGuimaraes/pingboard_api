//
//  PersonTableViewCell.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 14/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var personImage: CircularImage!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateCell(image : UIImage, name : String, details : String) {
        personImage.image = image
        personName.text = name
        personDetails.text = details
    }
}
