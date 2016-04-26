//
//  CDDCoreDataViewer.swift
//  AMAUtils
//
//  Created by Watkins, Richmond on 4/12/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import UIKit
import CoreData

public class RWCoreDataViewer: NSObject {
    
    static let sharedViewer: RWCoreDataViewer = RWCoreDataViewer()
    var amaEntities: [RWCoreDataEntity] = []
    var tapGesture: UITapGestureRecognizer!
    
    public static func initialize(moc: NSManagedObjectContext) {
        
        var amaEntities: [RWCoreDataEntity] = []
        
        for (name, description) in moc.persistentStoreCoordinator!.managedObjectModel.entitiesByName {
            
            if let classer = NSClassFromString(description.managedObjectClassName) as? NSManagedObject.Type {
                
                amaEntities.append(RWCoreDataEntity(entityName: name, properties: propertyNames(classer), moc: moc))
            }
        }
        
        showDebugView(amaEntities)
    }
    
    private static func showDebugView(amaEntities: [RWCoreDataEntity]) {
        
        RWCoreDataViewer.sharedViewer.amaEntities = amaEntities
        
        addWindowGestureRec()
    }
    
    internal static func addWindowGestureRec() {
        RWCoreDataViewer.sharedViewer.tapGesture = UITapGestureRecognizer(target: self, action: #selector(displayViewer))
        RWCoreDataViewer.sharedViewer.tapGesture.numberOfTapsRequired = 1

        UIApplication.sharedApplication().delegate?.window!?.addGestureRecognizer(RWCoreDataViewer.sharedViewer.tapGesture)
    }
    
    @objc private static func displayViewer() {
    
        let displayVC: CDDCoreDataDisplayViewController = UIStoryboard(name: "RWCoreDataStoryboard", bundle: NSBundle(forClass: RWCoreDataViewer.self)).instantiateViewControllerWithIdentifier(String(CDDCoreDataDisplayViewController.self)) as! CDDCoreDataDisplayViewController
        
        displayVC.setEntities(RWCoreDataViewer.sharedViewer.amaEntities)
        
        
        UIApplication.sharedApplication().delegate?.window!?.removeGestureRecognizer(RWCoreDataViewer.sharedViewer.tapGesture)
        UIApplication.sharedApplication().delegate!.window!!.rootViewController!.presentViewController(displayVC, animated: true, completion: nil)
    }
    
    private static func propertyNames(classToInspect: AnyObject.Type) -> [String] {
        
        var count : UInt32 = 0
        let properties : UnsafeMutablePointer <objc_property_t> = class_copyPropertyList(classToInspect, &count)
        var propertyNames : [String] = []
        let intCount = Int(count)
        
        for i in 0..<intCount {
            let property: objc_property_t = properties[i]
            let propertyName = NSString(UTF8String: property_getName(property))!
            
            propertyNames.append(propertyName as String)
        }
        
        free(properties)
        
        return propertyNames
    }
}
