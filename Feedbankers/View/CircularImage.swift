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
        self.layer.cornerRadius = self.bounds.width/2
    }

}
