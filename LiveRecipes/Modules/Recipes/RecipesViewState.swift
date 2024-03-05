//
//  RecipesViewState.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation

final class RecipesViewState: ObservableObject, RecipesViewStateProtocol {
    private let id = UUID()
    private var presenter: RecipesPresenterProtocol?

    func set(with presener: RecipesPresenterProtocol) {
        self.presenter = presener
    }
}
