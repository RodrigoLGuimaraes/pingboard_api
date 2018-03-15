//
//  BorderedCircularButton.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 13/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit

class BorderedCircularButton: UIButton {

    override func awakeFromNib() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.bounds.height/2
    }

}
