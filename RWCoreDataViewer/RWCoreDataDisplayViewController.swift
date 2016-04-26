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
    var entities: [RWCoreDataEntity]?
    
    func setEntities(entities: [RWCoreDataEntity]) {
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

            if let entity = entities.first {
             
                 updateCollectionViewWithEntity(entity)
            }
        }
        
        let flowlayout: UICollectionViewFlowLayout = self.objectCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowlayout.minimumLineSpacing = 2
        flowlayout.minimumInteritemSpacing = 2
    }
    
    func updateCollectionViewWithEntity(entity: RWCoreDataEntity) {
        
        let neededWidth: CGFloat = entity.properties.reduce(0) { (amount, property) -> CGFloat in
            return property.size.width + amount + 16
        }
        
        if neededWidth > self.view.frame.width - self.tableView.frame.width {
         
            self.collectionViewWidthConstraint.constant = neededWidth
            
            self.scrollView.contentSize = CGSize(width: neededWidth, height: self.objectCollectionView.contentSize.height)
            
            UIView.animateWithDuration(0.2, animations: {
                self.objectCollectionView.layoutIfNeeded()
            })
        }
        
        self.objectListingSource.entity = entity
        self.objectCollectionView.reloadData()
        
    }
    
    @IBAction func closeVC(sender: UIButton) {
        RWCoreDataViewer.addWindowGestureRec()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension CDDCoreDataDisplayViewController: RWTableEntitySourceDelegate {
    
    func didSelectEntitiy(entity: RWCoreDataEntity, atIndexPath indexPath: NSIndexPath) {
        updateCollectionViewWithEntity(entity)
    }
}
