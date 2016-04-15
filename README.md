# RWCoreDataViewer

RWCoreDataViewer is the simplest way to view your app's persisted Core Data store objects. RWCoreDataViewer presents a custom data viewer that lets you view all of your tables and the records that lie within.

### Installation
Add ``` pod 'RWCoreDataViewer', :git => 'https://github.com/richmondwatkins/RWCoreDataViewer' ``` to you Podfile

### Use
Make your managed object's a memeber of the RWCoreDataInspector protocol. (There is nothing to implement here just include it in your class declaration)

``` 
import Foundation
import CoreData
import RWCoreDataViewer

class EntityTwo: NSManagedObject, RWCoreDataInspector {

}
```

To display your data just paste in:

```
RWCoreDataViewer.initialize(self.managedObjectContext
``` 

### Core Data Utilities

Serialize your Core Data store to JSON with the ManagedObjectContext Extensions

```
self.managedObjectContext.toJSON()
```