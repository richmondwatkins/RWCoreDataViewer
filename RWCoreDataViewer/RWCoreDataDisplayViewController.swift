//
//  AMACoreDataDisplayViewController.swift
//  AMAUtils
//
//  Created by Watkins, Richmond on 4/13/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import UIKit

class CDDCoreDataDisplayViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var objectCollectionView: UICollectionView!
    @IBOutlet var objectListingSource: RWObjectListingCollectionSource!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var tableSouce: RWTableEntitySource!
    var entities: [CDDCoreDataEntity]?
    
    func setEntities(entities: [CDDCoreDataEntity]) {
        self.entities = entities
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension

        if let entities = self.entities {
            self.tableSouce.delegate = self
            self.tableSouce.entities = entities
            
            self.tableView.reloadData()
            
            self.tableView.selectRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0),animated: false, scrollPosition: .None)

            updateCollectionViewWithEntity(entities.first!)
        }
        
        let flowlayout: UICollectionViewFlowLayout = self.objectCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowlayout.minimumLineSpacing = 2
        flowlayout.minimumInteritemSpacing = 2
    }
    
    func updateCollectionViewWithEntity(entity: CDDCoreDataEntity) {
        
        let neededWidth: CGFloat = entity.properties.reduce(0) { (amount, property) -> CGFloat in
            return property.size.width + amount + 16
        }
                
        self.collectionViewWidthConstraint.constant = neededWidth

        self.scrollView.contentSize = CGSize(width: neededWidth, height: self.objectCollectionView.contentSize.height)
        
        print("SIZE: \(neededWidth)")
        
        UIView.animateWithDuration(0.2, animations: {
            self.objectCollectionView.layoutIfNeeded()
        })
        
        self.objectListingSource.entity = entity
        self.objectCollectionView.reloadData()
        
    }
}

extension CDDCoreDataDisplayViewController: RWTableEntitySourceDelegate {
    
    func didSelectEntitiy(entity: CDDCoreDataEntity, atIndexPath indexPath: NSIndexPath) {
        updateCollectionViewWithEntity(entity)
    }
}
