# RWCoreDataViewer

RWCoreDataViewer is the simplest way to view your app's persisted Core Data store objects. RWCoreDataViewer presents a custom data viewer that lets you view all of your tables and their records.

### Installation
Add ``` pod 'RWCoreDataViewer' ``` to your Podfile

### Use

To initialize the debug viewer include the following in you AppDelegate:

```
managedObjectContext.initDebugView()
``` 

When you want to display the viewer just triple tap anywhere on the screen.

#### Other Core Data Utilities

Retrieve all of your persisted data as a JSON string with the ManagedObjectContext Extension

```
managedObjectContext.toJSON()
```