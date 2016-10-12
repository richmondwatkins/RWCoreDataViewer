//
//  ManagedObjectContextExtension.swift
//  DebuggerTester
//
//  Created by Watkins, Richmond on 4/15/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import CoreData

public extension NSManagedObjectContext {
    
    public func initDebugView() {
        RWCoreDataViewer.initialize(self)
    }
    
    public func toJSON() -> String? {
        let entities: [String: NSEntityDescription] = self.persistentStoreCoordinator!.managedObjectModel.entitiesByName
        let userDictionary: NSMutableDictionary = NSMutableDictionary()
        let entityDictionary: NSMutableDictionary = NSMutableDictionary()
        
        userDictionary.setObject(entityDictionary, forKey: "Entities" as NSCopying)
        
        // Loop through and fetch entities
        for (entityName, _) in entities {
            
            let entityDescription: NSEntityDescription = NSEntityDescription.entity(forEntityName: entityName, in: self)!
            
            let fetchRequest = NSFetchRequest<NSManagedObject>()
            
            fetchRequest.entity = entityDescription
            
            do {
                let results: NSArray = try self.persistentStoreCoordinator!.execute(fetchRequest, with: self) as! NSArray
                
                let resultsMutArray: NSMutableArray = NSMutableArray()
                
                // Loops through each manage object from the fetch above, creates a dictionary out
                // of all of its values and keys and then puts it into an array
                for result in results as! [NSManagedObject] {
                    
                    let attrDictionary: NSMutableDictionary = NSMutableDictionary()
                    
                    let entity: NSEntityDescription = result.entity
                    let attributes: NSDictionary = entity.attributesByName as NSDictionary
                    
                    for (attr, _) in attributes as! [String: NSAttributeDescription] {
                        
                        attrDictionary.setObject("\(result.value(forKey: attr))", forKey: attr as NSCopying)
                    }
                    
                    resultsMutArray.add(attrDictionary)
                }
                
                // adds array from above to a dictionary that holds all of the values for the entity
                // that is currently being looped through
                entityDictionary.setObject(resultsMutArray, forKey: entityName as NSCopying)
                
            } catch {
                return nil
            }
        }
        
        do {
            
            let theJSONData = try JSONSerialization.data(
                withJSONObject: userDictionary,
                options: JSONSerialization.WritingOptions(rawValue: 0))
            
            return NSString(data: theJSONData,
                                       encoding: String.Encoding.ascii.rawValue) as? String
            
        } catch {
            
            return nil
        }
    }
}
