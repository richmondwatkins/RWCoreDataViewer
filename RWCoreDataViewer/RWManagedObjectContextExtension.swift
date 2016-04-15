//
//  ManagedObjectContextExtension.swift
//  DebuggerTester
//
//  Created by Watkins, Richmond on 4/15/16.
//  Copyright © 2016 Asurion. All rights reserved.
//

import CoreData

public extension NSManagedObjectContext {
    
    public func toJSON() -> String? {
        let entities: [String: NSEntityDescription] = self.persistentStoreCoordinator!.managedObjectModel.entitiesByName
        let userDictionary: NSMutableDictionary = NSMutableDictionary()
        let entityDictionary: NSMutableDictionary = NSMutableDictionary()
        
        userDictionary.setObject(entityDictionary, forKey: "Entities")
        
        // Loop through and fetch entities
        for (entityName, _) in entities {
            
            let entityDescription: NSEntityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: self)!
            
            let fetchRequest = NSFetchRequest()
            
            fetchRequest.entity = entityDescription
            
            do {
                let results: NSArray = try self.persistentStoreCoordinator!.executeRequest(fetchRequest, withContext: self) as! NSArray
                
                let resultsMutArray: NSMutableArray = NSMutableArray()
                
                // Loops through each manage object from the fetch above, creates a dictionary out
                // of all of its values and keys and then puts it into an array
                for result in results as! [NSManagedObject] {
                    
                    let attrDictionary: NSMutableDictionary = NSMutableDictionary()
                    
                    let entity: NSEntityDescription = result.entity
                    let attributes: NSDictionary = entity.attributesByName
                    
                    for (attr, _) in attributes as! [String: NSAttributeDescription] {
                        
                        attrDictionary.setObject("\(result.valueForKey(attr))", forKey: attr)
                    }
                    
                    resultsMutArray.addObject(attrDictionary)
                }
                
                // adds array from above to a dictionary that holds all of the values for the entity
                // that is currently being looped through
                entityDictionary.setObject(resultsMutArray, forKey: entityName)
                
            } catch {
                return nil
            }
        }
        
        do {
            
            let theJSONData = try NSJSONSerialization.dataWithJSONObject(
                userDictionary,
                options: NSJSONWritingOptions(rawValue: 0))
            
            return NSString(data: theJSONData,
                                       encoding: NSASCIIStringEncoding) as? String
            
        } catch {
            
            return nil
        }
    }
}