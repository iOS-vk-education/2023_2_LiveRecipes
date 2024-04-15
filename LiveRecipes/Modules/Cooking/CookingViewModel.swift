//
//  CookingViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class CookingViewModel: ObservableObject, CookingViewModelProtocol {
    var model: CookingModelProtocol
    var steps = [[String: String]]()

    init(cookingModel: CookingModelProtocol) {
        self.model = cookingModel
    }
    
    func findSteps() {
        self.steps = [["image": "step1", "description": "Описание шага 1"], ["image": "step2", "description": "Описание шага 2"]]
    }
}
