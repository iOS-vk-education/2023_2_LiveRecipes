//
//  RecipesViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Combine
import Foundation

final class RecipesViewModel: ObservableObject, RecipesViewModelProtocol {
    var model: RecipesModelProtocol
    @Published var foundRecipes: [RecipeDTO] = []
    @Published var searchQuery = "Egg"
    @Published var searchIsActive = false
    @Published var keyWords: [KeyWord] = []
    @Published var allRecipes: [Recipe] = []
    @Published var recentRecipes: [Recipe] = []
    @Published var myRecipes: [Recipe] = []

    @Published var modalFiltersIsOpen: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []

    init(recipesModel: RecipesModel) {
        self.model = recipesModel

        $searchQuery
                    .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
                    .removeDuplicates()
                    .sink { [weak self] _ in
                        self?.findRecipes()
                    }
                    .store(in: &cancellables)

        model.findRecipe(name: searchQuery, completion: { [weak self] result in
            self?.foundRecipes = result
        })
        loadAllData()
    }

    func findRecipes() {
        model.findRecipe(name: searchQuery) { [weak self] result in
            self?.foundRecipes = result
        }
    }
    
    func loadAllData() {
        keyWords = model.loadKeyWords()
        allRecipes = model.loadAllRecipes()
        recentRecipes = model.loadRecentRecipes()
        myRecipes = model.loadMyRecipes()
    }
    
    func sortKeyWordsByChoose() {
        keyWords.sort {
            $0.isChoosed && !$1.isChoosed
        }
    }
}
