//
//  CDDEntityTableViewCell.swift
//  AMAUtils
//
//  Created by Watkins, Richmond on 4/13/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import UIKit

class RWEntityTableViewCell: UITableViewCell {

    @IBOutlet weak var entityNameLabel: UILabel!

    func configure(entity: RWCoreDataEntity) {
        
        self.entityNameLabel.text = entity.entityName
    }
}
