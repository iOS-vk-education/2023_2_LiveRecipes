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
    @Published var foundRecipesToTime: [RecipeDTO] = []
    
    @Published var searchQuery = ""
    @Published var searchQueryAll = ""
    @Published var searchQueryToTime = ""
    @Published var type: NameToTime?
    
    @Published var pageAll = 1
    @Published var scrollID: Int?
    @Published var isLoadingAll: Bool = false
        
    @Published var searchIsActive = false
    @Published var searchIsActiveAll = false
    
    @Published var keyWords: [KeyWord] = []
    @Published var allRecipes: [RecipeDTO] = []
    @Published var recentRecipes: [RecipeDTO] = []
    @Published var myRecipes: [RecipeDTO] = []
    @Published var recipesForTime: [RecipeDTO] = []
    
    @Published var modalFiltersIsOpenFromMain: Bool = false
    @Published var modalFiltersIsOpenFromAll: Bool = false
    @Published var modalFiltersIsOpenFromRecents: Bool = false
    @Published var modalFiltersIsOpenFromMy: Bool = false
    @Published var modalFiltersIsOpenFromTime: Bool = false
    @Published var modalKeyWordsIsOpen: Bool = false
    
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
        
        $searchQueryAll
                    .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
                    .removeDuplicates()
                    .sink { [weak self] _ in
                        self?.findRecipesAll()
                    }
                    .store(in: &cancellables)
        
        $searchQueryToTime
                    .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
                    .removeDuplicates()
                    .sink { [weak self] _ in
                        self?.findRecipesToTime()
                    }
                    .store(in: &cancellables)

        loadAllData()
    }

    func findRecipes() {
        model.findRecipe(name: searchQuery) { [weak self] result in
            self?.foundRecipes = result
        }
    }
    
    func findRecipesAll() {
        model.findRecipe(name: searchQueryAll) { [weak self] result in
            self?.foundRecipes = result
        }
        DispatchQueue.main.sync {
            self.isLoadingAll = false
            print(self.isLoadingAll)
        }
    }
    
    func findRecipesToTime() {
        model.findRecipesToTime(type: type ?? .breakfast, name: searchQueryToTime) { [weak self] result in
            self?.foundRecipesToTime = result
        }
    }
    
    func loadAllRecipes() {
        model.getAllRecipes(page: pageAll) { [weak self] result in
            self?.allRecipes = result
        }
    }
    
    func loadMoreAllRecipes() {
        if (scrollID ?? 0 > allRecipes.count - 5) {
            pageAll += 1
            model.getAllRecipes(page: pageAll) { [weak self] result in
                self?.allRecipes.append(contentsOf: result)
            }
        }
    }
    
    func loadToTimeRecipes(chosenOption: NameToTime) {
        model.getToTimeRecipes(name: chosenOption) { [weak self] result in
            self?.recipesForTime = result
        }
    }

    func loadAllData() {
        loadAllRecipes()
        keyWords = model.loadKeyWords()
        recentRecipes = model.loadRecentRecipes()
        myRecipes = model.loadMyRecipes()
    }
    
    func sortKeyWordsByChoose() {
        keyWords.sort {
            $0.isChoosed && !$1.isChoosed
        }
    }
}
