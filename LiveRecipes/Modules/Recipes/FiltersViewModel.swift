//
//  FiltersViewModel.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 10.04.2024.
//

import Foundation
import Combine

final class FiltersViewModel: ObservableObject {
    var model: RecipesModelProtocol
    
    init(model: RecipesModelProtocol) {
        self.model = model
    }
    
    
}
