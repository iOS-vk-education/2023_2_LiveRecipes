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
    @Published var foundRecipes: [RecipePreviewDTO] = []
    @Published var foundRecipesToTime: [RecipePreviewDTO] = []
    
    @Published var searchQuery = ""
    @Published var searchQueryAll = ""
    @Published var searchQueryToTime = ""
    @Published var type: NameToTime?
    @Published var isEmptyFoundToTime = false
    @Published var isEmptyToTime = false
    
    @Published var filtersIsActive = false
    @Published var keyWordsSearchArr: [String] = []
    
    @Published var pageAll = 1
    @Published var scrollID: Int?
    @Published var isLoading: Bool = true
    @Published var isLoading1: Bool = true
        
    @Published var searchIsActive = false
    @Published var searchIsActiveAll = false
    
    @Published var keyWords: [KeyWord] = []
    @Published var allRecipes: [RecipePreviewDTO] = []
    @Published var recentRecipes: [RecipePreviewDTO] = []
    @Published var myRecipes: [RecipePreviewDTO] = []
    @Published var recipesForTime: [RecipePreviewDTO] = []
    
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
                        self?.findRecipesByFilter()
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
            DispatchQueue.main.async {
                self?.isLoading = false
            }
        }
    }
    
    func findRecipesAll() {
        model.findRecipe(name: searchQueryAll) { [weak self] result in
            self?.foundRecipes = result
            DispatchQueue.main.async {
                self?.isLoading = false
            }
        }
    }
    
    func findRecipesToTime() {
        model.findRecipesToTime(type: type ?? .breakfast, name: searchQueryToTime) { [weak self] result in
            self?.foundRecipesToTime = result
            DispatchQueue.main.async {
                self?.isLoading = false
            }
        }
    }
    
    func loadAllRecipes() {
        model.getAllRecipes(page: pageAll) { [weak self] result in
            self?.allRecipes = result
            DispatchQueue.main.async {
                self?.isLoading1 = false
            }
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
    
    func loadToTimeRecipes() {
        model.getToTimeRecipes(name: type ?? .breakfast) { [weak self] result in
            self?.recipesForTime = result
            DispatchQueue.main.async {
                self?.isLoading = false
            }
        }
    }

    func loadAllData() {
        loadAllRecipes()
        keyWords = model.loadKeyWords()
    }
    
    func sortKeyWordsByChoose() {
        keyWords.sort {
            $0.isChoosed && !$1.isChoosed
        }
    }
    
    func findRecipesByFilter() {
        model.findRecipesByFilter(query: searchQuery, keyWords: keyWordsSearchArr) { [weak self] result in
            self?.foundRecipes = result
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.filtersIsActive = false
            }
        }
    }
    
    func keywordSearch(word: KeyWord) {
        if (word.isChoosed) {
            print(word.isChoosed)
            if keyWordsSearchArr.count < 5 {
                filtersIsActive = true
                keyWordsSearchArr.append(word.keyWord)
            }
        } else {
            keyWordsSearchArr = keyWordsSearchArr.filter{$0 != word.keyWord}
        }
        findRecipesByFilter()
    }
    func isFilterActive() -> Bool {
        if !keyWordsSearchArr.isEmpty { return true }
        if searchQuery != "" { return true }
        return false
    }
}
