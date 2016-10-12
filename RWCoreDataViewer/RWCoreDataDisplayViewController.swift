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
    
    func setEntities(_ entities: [RWCoreDataEntity]) {
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
            
            self.tableView.selectRow(at: IndexPath(item: 0, section: 0),animated: false, scrollPosition: .none)

            if let entity = entities.first {
             
                 updateCollectionViewWithEntity(entity)
            }
        }
        
        let flowlayout: UICollectionViewFlowLayout = self.objectCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowlayout.minimumLineSpacing = 2
        flowlayout.minimumInteritemSpacing = 2
    }
    
    func updateCollectionViewWithEntity(_ entity: RWCoreDataEntity) {
        
        let neededWidth: CGFloat = entity.properties.reduce(0) { (amount, property) -> CGFloat in
            return property.size.width + amount + 16
        }
        
        if neededWidth > self.view.frame.width - self.tableView.frame.width {
         
            self.collectionViewWidthConstraint.constant = neededWidth
            
            self.scrollView.contentSize = CGSize(width: neededWidth, height: self.objectCollectionView.contentSize.height)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.objectCollectionView.layoutIfNeeded()
            })
        }
        
        self.objectListingSource.entity = entity
        self.objectCollectionView.reloadData()
        
    }
    
    @IBAction func closeVC(_ sender: UIButton) {
        RWCoreDataViewer.addWindowGestureRec()
        self.dismiss(animated: true, completion: nil)
    }
}

extension CDDCoreDataDisplayViewController: RWTableEntitySourceDelegate {
    
    func didSelectEntitiy(_ entity: RWCoreDataEntity, atIndexPath indexPath: IndexPath) {
        updateCollectionViewWithEntity(entity)
    }
}
