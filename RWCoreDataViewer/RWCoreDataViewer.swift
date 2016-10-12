//
//  CDDCoreDataViewer.swift
//  AMAUtils
//
//  Created by Watkins, Richmond on 4/12/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import UIKit
import CoreData

open class RWCoreDataViewer: NSObject {
    
    static let sharedViewer: RWCoreDataViewer = RWCoreDataViewer()
    var amaEntities: [RWCoreDataEntity] = []
    var tapGesture: UITapGestureRecognizer!
    
    open static func initialize(_ moc: NSManagedObjectContext) {
        
        var amaEntities: [RWCoreDataEntity] = []
        
        for (name, description) in moc.persistentStoreCoordinator!.managedObjectModel.entitiesByName {
            
            if let classer = NSClassFromString(description.managedObjectClassName) as? NSManagedObject.Type {
                
                amaEntities.append(RWCoreDataEntity(entityName: name, properties: propertyNames(classer), moc: moc))
            }
        }
        
        showDebugView(amaEntities)
    }
    
    fileprivate static func showDebugView(_ amaEntities: [RWCoreDataEntity]) {
        
        RWCoreDataViewer.sharedViewer.amaEntities = amaEntities
        
        addWindowGestureRec()
    }
    
    internal static func addWindowGestureRec() {
        RWCoreDataViewer.sharedViewer.tapGesture = UITapGestureRecognizer(target: self, action: #selector(displayViewer))
        RWCoreDataViewer.sharedViewer.tapGesture.numberOfTapsRequired = 1

        UIApplication.shared.delegate?.window!?.addGestureRecognizer(RWCoreDataViewer.sharedViewer.tapGesture)
    }
    
    @objc fileprivate static func displayViewer() {
    
        let displayVC: CDDCoreDataDisplayViewController = UIStoryboard(name: "RWCoreDataStoryboard", bundle: Bundle(for: RWCoreDataViewer.self)).instantiateViewController(withIdentifier: String(describing: CDDCoreDataDisplayViewController.self)) as! CDDCoreDataDisplayViewController
        
        displayVC.setEntities(RWCoreDataViewer.sharedViewer.amaEntities)
        
        
        UIApplication.shared.delegate?.window!?.removeGestureRecognizer(RWCoreDataViewer.sharedViewer.tapGesture)
        UIApplication.shared.delegate!.window!!.rootViewController!.present(displayVC, animated: true, completion: nil)
    }
    
    fileprivate static func propertyNames(_ classToInspect: AnyObject.Type) -> [String] {
        
        var count : UInt32 = 0
        let properties : UnsafeMutablePointer <objc_property_t?>! = class_copyPropertyList(classToInspect, &count)
        var propertyNames : [String] = []
        let intCount = Int(count)
        
        for i in 0..<intCount {
            let property: objc_property_t = properties[i]!
            let propertyName = NSString(utf8String: property_getName(property))!
            
            propertyNames.append(propertyName as String)
        }
        
        free(properties)
        
        return propertyNames
    }
}
