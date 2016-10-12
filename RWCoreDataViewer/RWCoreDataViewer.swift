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
    var tapGesture: UITapGestureRecognizer! {
        didSet {
            tapGesture.delegate = self
        }
    }
    
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
        RWCoreDataViewer.sharedViewer.tapGesture.numberOfTapsRequired = 3

        print( UIApplication.shared.delegate?.window!)
        UIApplication.shared.delegate?.window!?.addGestureRecognizer(RWCoreDataViewer.sharedViewer.tapGesture)
    }
    
    @objc fileprivate static func displayViewer() {
    
        let displayVC: CDDCoreDataDisplayViewController = UIStoryboard(name: "RWCoreDataStoryboard", bundle: Bundle(for: RWCoreDataViewer.self)).instantiateViewController(withIdentifier: String(describing: CDDCoreDataDisplayViewController.self)) as! CDDCoreDataDisplayViewController
        
        displayVC.setEntities(RWCoreDataViewer.sharedViewer.amaEntities)
        
        
        UIApplication.shared.delegate?.window!?.removeGestureRecognizer(RWCoreDataViewer.sharedViewer.tapGesture)
        UIApplication.shared.delegate!.window!!.rootViewController!.presentViewControllerFromVisibleViewController(viewControllerToPresent: displayVC, animated: true, completion: nil)
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

extension RWCoreDataViewer: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension UIViewController {
    func presentViewControllerFromVisibleViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if let navigationController = self as? UINavigationController {
            navigationController.topViewController?.presentViewControllerFromVisibleViewController(viewControllerToPresent: viewControllerToPresent, animated: flag, completion: completion)
        } else if let tabBarController = self as? UITabBarController {
            tabBarController.selectedViewController?.presentViewControllerFromVisibleViewController(viewControllerToPresent: viewControllerToPresent, animated: flag, completion: completion)
        } else if let presentedViewController = presentedViewController {
            presentedViewController.presentViewControllerFromVisibleViewController(viewControllerToPresent: viewControllerToPresent, animated: flag, completion: completion)
        } else {
            present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
}
