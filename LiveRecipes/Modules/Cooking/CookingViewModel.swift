//
//  CookingViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class CookingViewModel: ObservableObject, CookingViewModelProtocol {
    var model: CookingModelProtocol

    init(cookingModel: CookingModelProtocol) {
        self.model = cookingModel
    }
}
