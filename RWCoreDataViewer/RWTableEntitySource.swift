//
//  CDDTableEntitySource.swift
//  AMAUtils
//
//  Created by Watkins, Richmond on 4/13/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import UIKit

protocol RWTableEntitySourceDelegate {
    func didSelectEntitiy(entity: RWCoreDataEntity, atIndexPath indexPath: NSIndexPath)
}

class RWTableEntitySource: NSObject, UITableViewDelegate, UITableViewDataSource {

    var entities: [RWCoreDataEntity] = []
    var delegate: RWTableEntitySourceDelegate?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: RWEntityTableViewCell = tableView.dequeueReusableCellWithIdentifier(String(RWEntityTableViewCell.self)) as! RWEntityTableViewCell
        
        cell.configure(entities[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.didSelectEntitiy(self.entities[indexPath.row], atIndexPath: indexPath)
    }
}
