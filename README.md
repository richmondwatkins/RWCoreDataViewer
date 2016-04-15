# RWCoreDataViewer

RWCoreDataViewer is the simpelest way to view your app's persisted data. During the development and debugging process it is very common for a developer to want to view the data that has been peristed. Most of the time this means that the developer is forced to write all of the code to fetch the data and then log it out. With one line of code, RWCoreDataViewer presents a custom data viewer that lets you view all of your tables and the records that lie within. This cuts down on development time and allows you to focus on the code.

### Installation
Add ``` pod 'RWCoreDataViewer', :git => 'https://github.com/richmondwatkins/RWCoreDataViewer' ``` to you Podfile

### Use
Make your managed object's a memeber of the RWCoreDataInspector protocol. (There is nothing to implement here just include it in your class declaration)
```import Foundation
import CoreData
import RWCoreDataViewer

class EntityTwo: NSManagedObject, RWCoreDataInspector {

}
```

Wherever you want to display your data, just include
``` RWCoreDataViewer.initialize(self.managedObjectContext)``` and you will be presented with the custom RWCoreDataViewer view