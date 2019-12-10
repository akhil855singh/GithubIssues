//
//  CoreDataStack.swift
//  GithubIssues
//
//  Created by Akhil Singh on 08/12/19.
//  Copyright © 2019 Akhil Singh. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GithubIssues")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    class func saveContext () {
        let context = persistentContainer.viewContext
        
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    class func getAllIssues() -> [Issue]{
        var issues  = [Issue]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Issue")
        let dateSortDescriptor = NSSortDescriptor(key: "createdTime", ascending: false)
        let sortDescriptors = [dateSortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            let results = try CoreDataStack.context.fetch(fetchRequest)
            if let fetchedIssues = results as? [Issue]{
                issues = fetchedIssues
            }
        }catch let err as NSError {
            print(err.debugDescription)
        }
        return issues
    }
}

