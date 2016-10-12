//
//  CDDTableEntitySource.swift
//  AMAUtils
//
//  Created by Watkins, Richmond on 4/13/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import UIKit

protocol RWTableEntitySourceDelegate {
    func didSelectEntitiy(_ entity: RWCoreDataEntity, atIndexPath indexPath: IndexPath)
}

class RWTableEntitySource: NSObject, UITableViewDelegate, UITableViewDataSource {

    var entities: [RWCoreDataEntity] = []
    var delegate: RWTableEntitySourceDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: RWEntityTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: RWEntityTableViewCell.self)) as! RWEntityTableViewCell
        
        cell.configure(entities[(indexPath as NSIndexPath).row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectEntitiy(self.entities[(indexPath as NSIndexPath).row], atIndexPath: indexPath)
    }
}
