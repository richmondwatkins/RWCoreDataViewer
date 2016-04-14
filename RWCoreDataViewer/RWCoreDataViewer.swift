//
//  CDDCoreDataViewer.swift
//  AMAUtils
//
//  Created by Watkins, Richmond on 4/12/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import UIKit
import CoreData

public protocol RWCoreDataInspector {
    func propertyNames(classToInspect: AnyObject.Type) -> [String]
}

public extension RWCoreDataInspector {
    func propertyNames(classToInspect: AnyObject.Type) -> [String] {
        
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

public class RWCoreDataViewer: NSObject {

    public static func initialize(moc: NSManagedObjectContext) {
        
        var amaEntities: [RWCoreDataEntity] = []
        
        for (name, description) in moc.persistentStoreCoordinator!.managedObjectModel.entitiesByName {
            
            if let classer = NSClassFromString(description.managedObjectClassName) as? NSManagedObject.Type {
                
                if let protoClass = classer.init(entity: description, insertIntoManagedObjectContext: moc) as? RWCoreDataInspector {
      
                    amaEntities.append(RWCoreDataEntity(entityName: name, properties: protoClass.propertyNames(classer), moc: moc))
                }
            }
        }
        
        showDebugView(amaEntities)
    }
    
    private static func showDebugView(amaEntities: [RWCoreDataEntity]) {
     
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            let displayVC: CDDCoreDataDisplayViewController = UIStoryboard(name: "RWCoreDataStoryboard", bundle: NSBundle(forClass: RWCoreDataViewer.self)).instantiateViewControllerWithIdentifier(String(CDDCoreDataDisplayViewController.self)) as! CDDCoreDataDisplayViewController
            
            displayVC.setEntities(amaEntities)
            
            UIApplication.sharedApplication().delegate!.window!!.rootViewController!.presentViewController(displayVC, animated: true, completion: nil)
        }
    }
}
