//
//  RecipeDataManager.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 02.05.2024.
//

import Foundation
import CoreData

protocol RecipeDataManagerDescription {
    func create(id: Int?, dish: Dish, completion: @escaping() -> Void)
    func fetch(completion: @escaping([Dish]) -> Void)
    func delete(recipeMyId: Int, completion: @escaping (Bool) -> Void)
    func delete(recipeNetId: Int, completion: @escaping (Bool) -> Void)
    func deleteAll(completion: @escaping() -> Void)
    func prepareCoreDataIfNeeded(completion: (() -> ())?)
    var viewContext: NSManagedObjectContext { get }
}
final class RecipeDataManager: RecipeDataManagerDescription {
    static let shared = RecipeDataManager()
    private let container: NSPersistentContainer
    private var isReady: Bool = false
    lazy var viewContext: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    private init() {
        self.container = NSPersistentContainer(name: "LiveRecipesDB")
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }
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
    func create(id: Int?, dish: Dish, completion: @escaping() -> Void) {
        container.performBackgroundTask { context in
            guard let objectRecipeEntity = NSEntityDescription.insertNewObject(forEntityName: "CreationRecipeEntity", into: context) as? CreationRecipeEntity else {
                return
            }
            if let netId = id {
                objectRecipeEntity.recipeMyId = Int64(netId)
                objectRecipeEntity.recipeNetId = -1
            } else {
                let countDishes = CoreDataManager.shared.count(request:CreationRecipeEntity.fetchRequest())
                let newDishId = Int64(countDishes + 1)
                objectRecipeEntity.recipeMyId = newDishId
                objectRecipeEntity.recipeNetId = -1
            }
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
            objectRecipeEntity.timeToPrepare = Int64(dish.timeToPrepare)//непонятная хрень
            for step in dish.dishSteps {
                guard let objectRecipeStepEntity = NSEntityDescription.insertNewObject(forEntityName: "CreationRecipeStepEntity", into: context) as? CreationRecipeStepEntity else {
                    return
                }
                objectRecipeStepEntity.recipe = objectRecipeEntity
                objectRecipeStepEntity.id = Int64(step.id)
                objectRecipeStepEntity.stepTime = Int64(step.stepTime)
                objectRecipeStepEntity.stepDescription = step.description
                if let photo = step.photo {
                    if let imageData = photo.jpegData(compressionQuality: 0.4) {
                        CreationPhotoFileManager.shared.savePhoto(imageData: imageData) { ref in
                            objectRecipeStepEntity.stepPhotoRef = ref
                        }
                    }
                } else {
                    objectRecipeStepEntity.stepPhotoRef = nil
                }
            }
            for composition in dish.dishComposition {
                guard let objectRecipeCompositionEntity = NSEntityDescription.insertNewObject(forEntityName: "CreationRecipeCompositionEntity", into: context) as? CreationRecipeCompositionEntity else {
                    return
                }
                objectRecipeCompositionEntity.recipe = objectRecipeEntity
                objectRecipeCompositionEntity.id = Int64(composition.id)
                objectRecipeCompositionEntity.product = composition.product
                objectRecipeCompositionEntity.quantity = composition.quantity
            }
            do {
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
            completion()
        }
    }
    func fetch(completion: @escaping([Dish]) -> Void) {
        var dishes: [Dish] = []
        if let recipeEntities = try? viewContext.fetch(CreationRecipeEntity.fetchRequest()) {
            for recipeEntity in recipeEntities {
                var stepsEntitie: [CreationRecipeStepEntity] = []
                var compositionsEntities: [CreationRecipeCompositionEntity] = []
                if let stepEntities = recipeEntity.step?.allObjects {
                    print(stepEntities)
                    if let stepsArray = Array(stepEntities) as? [CreationRecipeStepEntity] {
                        stepsEntitie = stepsArray
                    }
                }
                if let compositionEntities = recipeEntity.composition?.allObjects {
                    print(compositionEntities)
                    if let compositionsArray = Array(compositionEntities) as? [CreationRecipeCompositionEntity] {
                        compositionsEntities = compositionsArray
                    }
                }
                let dish = Dish(recipeEntity: recipeEntity, dishCompositionsEntities: compositionsEntities, dishStepsEntities: stepsEntitie)
                dishes.append(dish)
            }
            completion(dishes)
        } else {
            completion([])
        }
    }
    func deleteAll(completion: @escaping () -> Void) {
        let fetchRequest: NSFetchRequest<CreationRecipeEntity> = CreationRecipeEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try viewContext.execute(batchDeleteRequest)
            try viewContext.save()
            completion()
        } catch {
            print("Error deleting all CreationRecipeEntity entities: \(error)")
            completion()
        }
    }
    func delete(recipeMyId: Int, completion: @escaping (Bool) -> Void) {
        let fetchRequest: NSFetchRequest<CreationRecipeEntity> = CreationRecipeEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "recipeMyId == %d", recipeMyId)
        do {
            let results = try viewContext.fetch(fetchRequest)
            for object in results {
                viewContext.delete(object)
            }
            try viewContext.save()
            completion(true)
        } catch {
            print("Error deleting CreationRecipeEntity entities with ID \(recipeMyId): \(error)")
            completion(false)
        }
    }
    func delete(recipeNetId: Int, completion: @escaping (Bool) -> Void) {
        let fetchRequest: NSFetchRequest<CreationRecipeEntity> = CreationRecipeEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "recipeNetId == %d", recipeNetId)
        do {
            let results = try viewContext.fetch(fetchRequest)
            for object in results {
                viewContext.delete(object)
            }
            try viewContext.save()
            completion(true)
        } catch {
            print("Error deleting CreationRecipeEntity entities with ID \(recipeNetId): \(error)")
            completion(false)
        }
    }
}
