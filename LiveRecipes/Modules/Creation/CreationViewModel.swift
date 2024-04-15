//
//  CreationViewModel.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 26.03.2024.
//

//import Foundation
import SwiftUI

struct Dish: Identifiable {
    var id: Int
    var title: String
    var description: String
    var photo: UIImage?
    var timeToPrepare: Int
    var nutritionValue: (Int, Int, Int, Int)
    var dishComposition: [DishComposition]
    var dishSteps: [DishStep]
}
struct DishComposition: Identifiable {
    var id: Int
    var product: String
    var quantity: String
}
struct DishStep: Identifiable {
    var id: Int
    var title: String
    var description: String
    var photo: UIImage?
}

final class CreationViewModel: ObservableObject, CreationViewModelProtocol {
    
    var model: CreationModelProtocol
    @Published var dishComposition: [DishComposition] = [DishComposition(id: 0, product: "", quantity: "")] {
        didSet {
            if dishComposition.count == 0 {
                dishComposition.append(DishComposition(id: 0, product: "", quantity: ""))
            }
            print("-")
            for composition in dishComposition {
                print("dishComposition.id = \(composition.id)")
            }
        }
    }
    @Published var dishSteps: [DishStep] = []

    init(creationModel: CreationModelProtocol) {
        self.model = creationModel
    }
    func addDishComposition(product: String, quantity: String) {
        if let maxIdComposition = dishComposition.max(by: { $0.id < $1.id }) {
            dishComposition.append(DishComposition(id: maxIdComposition.id + 1, product: product, quantity: quantity))
        } else {
            dishComposition.append(DishComposition(id: 0, product: "", quantity: ""))
        }
    }
    func deleteDishComposition(index: Int) {
        if index >= 0 && index < dishComposition.count {
            dishComposition.remove(at: index)
        }
    }

    func addStepComposition(title: String, description: String, photo: UIImage?) {
        if let maxIdStep = dishSteps.max(by: { $0.id < $1.id }) {
            dishSteps.append(DishStep(id: maxIdStep.id + 1, title: title, description: description, photo: photo))
        } else {
            dishSteps.append(DishStep(id: 0, title: title, description: description, photo: photo))
        }
    }
    func addEmptyStep() {
        if let maxIdStep = dishSteps.max(by: { $0.id < $1.id }) {
            dishSteps.append(DishStep(id: maxIdStep.id + 1, title: "", description: "", photo: nil))
        } else {
            dishSteps.append(DishStep(id: 0, title: "creation.firstStep".localized, description: "", photo: nil))
        }
    }
    func editStepComposition(id: Int, title: String, description: String, photo: UIImage?) {
        if let index = dishSteps.firstIndex(where: { $0.id == id }) {
            dishSteps[index].title = title
            dishSteps[index].description = description
            dishSteps[index].photo = photo
        }
    }

    func deleteStepComposition(index: Int) {
        if index >= 0 && index < dishSteps.count {
            dishSteps.remove(at: index)
        }
    }
}
