//
//  CookingViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/13/24.
//

import Foundation


final class CookingViewModel: ObservableObject {
    var cookingModel: CookingModel

    init(cookingModel: CookingModel) {
        self.cookingModel = cookingModel
    }
}
