//
//  CoreData.swift
//  Education
//
//  Created by Ignacio Juarez on 9/8/24.
//
import CoreData
import Foundation

// Core Data
// Object Graph Data Persistant Framework

class CoreDataProvider {
    
    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext { container.viewContext }
    
    static var preview: CoreDataProvider = {
        let provider = CoreDataProvider(inMemory: true)
        let viewContext = provider.viewContext
        
        for index in 1 ..< 10 {
            let todoItem = TodoItem(context: viewContext)
            todoItem.title = "TodoItem \(index)"
        }
        do {
            try viewContext.save()
        } 
        catch {
            print(error)
        }
        return provider
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer (name: "TodoModel")
        
        if(inMemory == true) {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("ERROR \(error)")
            }
        }
    }
}
