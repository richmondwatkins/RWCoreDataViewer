//
//  CDDObjectCollectionViewCell.swift
//  AMAUtils
//
//  Created by Watkins, Richmond on 4/13/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import UIKit
import CoreData

class RWObjectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var objectValueLabel: UILabel!
    
    func configure(_ managedObject: NSManagedObject, propertyName: String) {
                
        if let value = managedObject.value(forKey: propertyName) {
            self.objectValueLabel.text = "\(value)"
        }
    }
}
