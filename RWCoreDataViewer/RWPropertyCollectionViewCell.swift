//
//  CDDPropertyCollectionViewCell.swift
//  AMAUtils
//
//  Created by Watkins, Richmond on 4/13/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import UIKit

class RWPropertyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var propertyNameLabel: UILabel!
   
    func configure(_ property: RWProperty) {
        
        self.propertyNameLabel.text = property.name
    }
}
