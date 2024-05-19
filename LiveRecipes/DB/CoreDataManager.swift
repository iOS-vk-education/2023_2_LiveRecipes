//
//  CoreDataManager.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 11.04.2024.
//

import Foundation
import CoreData

protocol CoreDataManagerDescription {
    func create<T: NSManagedObject>(entityName: String, configurationBlock: @escaping (T, NSManagedObjectContext) -> ())
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T]
    func count<T: NSManagedObject>(request: NSFetchRequest<T>) -> Int
    func delete<T: NSManagedObject>(request: NSFetchRequest<T>)
    func deleteAll(request: NSFetchRequest<NSFetchRequestResult>)
    func update<T: NSManagedObject>(request: NSFetchRequest<T>, configurationBlock: @escaping (T) -> ())
    func prepareCoreDataIfNeeded(completion: (() -> ())?)
    var viewContext: NSManagedObjectContext { get }
}
final class CoreDataManager {
    static let shared = CoreDataManager()
    private let container: NSPersistentContainer
    private var isReady: Bool = false
    lazy var viewContext: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    private init() {
        self.container = NSPersistentContainer(name: "LiveRecipesDB")
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
extension CoreDataManager: CoreDataManagerDescription {
    func prepareCoreDataIfNeeded(completion: (() -> ())?) {
        guard !isReady else {
            completion?()
            return
        }
        
        self.container.loadPersistentStores { [weak self] _, _ in
            self?.isReady = true
            completion?()
        }
    }
    
    // INSERT
    func create<T>(entityName: String, configurationBlock: @escaping (T, NSManagedObjectContext) -> ()) where T : NSManagedObject {
        container.performBackgroundTask { context in
            guard let object = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? T else {
                return
            }
            configurationBlock(object, context)
            try? context.save()
        }
    }
    
    // SELECT
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        return (try? viewContext.fetch(request)) ?? []
    }
    
    // COUNT OF OBJECTS
    func count<T: NSManagedObject>(request: NSFetchRequest<T>) -> Int {
        return (try? viewContext.count(for: request)) ?? 0
    }
    
    // DELETE
    func delete<T: NSManagedObject>(request: NSFetchRequest<T>) {
        let objects = fetch(request: request)
        
        objects.forEach({ viewContext.delete($0) })
        
        viewContext.performAndWait {
            try? viewContext.save()
        }
    }
    
    // DELETE ALL
    func deleteAll(request: NSFetchRequest<NSFetchRequestResult>) {
        let batchRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        viewContext.performAndWait {
            _ = try? viewContext.execute(batchRequest)
            try? viewContext.save()
        }
    }
    
    // UPDATE
    func update<T: NSManagedObject>(request: NSFetchRequest<T>, configurationBlock: @escaping (T) -> ()) {
        let objects = fetch(request: request)
        
        guard let object = objects.first else {
            return
        }
        
        configurationBlock(object)
        
        viewContext.performAndWait {
            try? viewContext.save()
        }
    }
}
