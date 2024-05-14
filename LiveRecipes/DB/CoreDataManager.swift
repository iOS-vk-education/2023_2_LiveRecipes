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
    func createRecipe(dish: Dish, completion: @escaping() -> Void) {
        container.performBackgroundTask { context in
            guard let objectRecipeEntity = NSEntityDescription.insertNewObject(forEntityName: "CreationRecipeEntity", into: context) as? CreationRecipeEntity else {
                return
            }
            let countDishes = CoreDataManager.shared.count(request:CreationRecipeEntity.fetchRequest())
            let newDishId = Int64(countDishes + 1)
            objectRecipeEntity.id = newDishId
            objectRecipeEntity.dishDescription = dish.description
            objectRecipeEntity.dishTitle = dish.title
            objectRecipeEntity.nutritionValueCal = dish.nutritionValue.calories
            objectRecipeEntity.nutritionValueProt = dish.nutritionValue.protein
            objectRecipeEntity.nutritionValueFats = dish.nutritionValue.fats
            objectRecipeEntity.nutritionValueCarb = dish.nutritionValue.carbohydrates
            if let photo = dish.photo {
                if let imageData = photo.jpegData(compressionQuality: 0.4) {
                    CreationPhotoFileManager.shared.savePhoto(imageData: imageData) { ref in
                        objectRecipeEntity.photoRef = ref
                    }
                }
            } else {
                objectRecipeEntity.photoRef = nil
            }
            objectRecipeEntity.timeToPrepare = Int64(dish.timeToPrepare)
            for step in dish.dishSteps {
                guard let objectRecipeStepEntity = NSEntityDescription.insertNewObject(forEntityName: "CreationRecipeStepEntity", into: context) as? CreationRecipeStepEntity else {
                    return
                }
                objectRecipeStepEntity.recipe = objectRecipeEntity
                objectRecipeStepEntity.id = Int64(step.id)
                objectRecipeStepEntity.stepTittle = step.title
                objectRecipeStepEntity.stepDescription = step.description
                objectRecipeStepEntity.photoRef = ""
            }
            do {
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
            completion()
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
