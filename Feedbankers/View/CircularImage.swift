//
//  CircularImage.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 14/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit

class CircularImage: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2.0
        self.layer.masksToBounds = true
        // POG to fix the corner radius
        self.layer.borderWidth = 0.1
        self.layer.borderColor = UIColor.white.cgColor
    }
    
}
