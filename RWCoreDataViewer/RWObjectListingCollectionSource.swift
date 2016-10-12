//
//  CDDCollectionSource.swift
//  AMAUtils
//
//  Created by Watkins, Richmond on 4/13/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import UIKit
import CoreData

class RWObjectListingCollectionSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var entity: RWCoreDataEntity?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let entity = self.entity {
            
            return entity.properties.count
        }
        
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if let entity = self.entity {
            
            return entity.fetchResults.count
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath as NSIndexPath).section == 0 {
            let cell: RWPropertyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RWPropertyCollectionViewCell.self), for: indexPath) as! RWPropertyCollectionViewCell
            
            cell.configure(self.entity!.properties[(indexPath as NSIndexPath).row])
            
            return cell
        } else {
         
            let cell: RWObjectCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RWObjectCollectionViewCell.self), for: indexPath) as! RWObjectCollectionViewCell
            
            if let record: NSManagedObject = self.entity!.fetchResults[(indexPath as NSIndexPath).section] as? NSManagedObject {
                
                cell.configure(record, propertyName: self.entity!.properties[(indexPath as NSIndexPath).row].name)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         return self.entity!.properties[(indexPath as NSIndexPath).row].size
    }
}
