//
//  CircularView.swift
//  Feedbankers
//
//  Created by Pedro Marcos Derkacz on 14/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit

class CircularView: UIView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        // POG to fix the corner radius
        self.layer.borderWidth = 30
        self.layer.borderColor = UIColor.white.cgColor
    }
    
}
