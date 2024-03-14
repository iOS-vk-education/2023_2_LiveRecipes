//
//  ListViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class ListViewModel: ObservableObject, ListViewModelProtocol {
    var model: ListModelProtocol

    init(recipesModel: ListModelProtocol) {
        self.model = recipesModel
    }
}
