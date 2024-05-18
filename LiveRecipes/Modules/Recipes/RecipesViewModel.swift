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
    
    //результаты поиска
    @Published var foundRecipes: [RecipePreviewDTO] = []
    @Published var foundRecipesToTime: [RecipePreviewDTO] = []
    @Published var foundRecipesRecentsLocal: [RecipePreviewDTO] = []
    
    //поиск
    @Published var searchQuery = ""
    @Published var searchQueryAll = ""
    @Published var searchQueryToTime = ""
    @Published var searchQueryLocalRecents = ""
    @Published var searchIsActive = false
    @Published var searchIsActiveAll = false
    
    //cook to time block
    @Published var type: NameToTime?
    @Published var isEmptyFoundToTime = false
    @Published var isEmptyToTime = false
    
    //фильтры
    @Published var filtersIsActive = false
    @Published var keyWordsSearchArr: [String] = []
    @Published var duration: Double = 0
    @Published var calories: Double = 0
    @Published var containsTextField: String = ""
    @Published var notContainsTextField: String = ""
    @Published var contains: [String] = []
    @Published var notContains: [String] = []
    
    //лента во всех рецептах
    @Published var pageAll = 1
    @Published var scrollID: Int?
    
    //для сохраненных
    @Published var favoritesID: [Int] = []
    
    //отслеживание загрузки
    @Published var isLoading: Bool = true
    @Published var isLoading1: Bool = true
    @Published var isLoadingRecents: Bool = true
        
    //данные
    @Published var keyWords: [KeyWord] = []
    @Published var allRecipes: [RecipePreviewDTO] = []
    @Published var recentRecipes: [RecipePreviewDTO] = []
    @Published var myRecipes: [RecipePreviewDTO] = []
    @Published var recipesForTime: [RecipePreviewDTO] = []
    
    //работа с модальным окном фильтров
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
        loadRecents()
        keyWords = model.loadKeyWords()
    }
    
    func loadRecents() {
        recentRecipes = []
        let arrayOfRecentsID = UserDefaults.standard.array(forKey: "recentsID") as? [Int] ?? []
        for id in arrayOfRecentsID {
            model.findRecipe(id: id) { [weak self] result in
                self?.recentRecipes.append(result)
                DispatchQueue.main.async {
                    self?.isLoadingRecents = false
                }
            }
        }
    }
    
    func sortKeyWordsByChoose() {
        keyWords.sort {
            $0.isChoosed && !$1.isChoosed
        }
    }
    
    func findRecipesByFilter() {
        model.findRecipesByFilter(query: searchQuery, keyWords: keyWordsSearchArr, duration: Int(duration), calories: String(Int(calories)), contains: contains, notContains: notContains) { [weak self] result in
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
            keyWordsSearchArr = keyWordsSearchArr.filter{ $0 != word.keyWord }
        }
        findRecipesByFilter()
    }
    
    func addToContains(word: String) {
        if contains.count < 5 && word != "" {
            contains.append(word)
        }
    }
    func addToNotContains(word: String) {
        if notContains.count < 5 && word != "" {
            notContains.append(word)
        }
    }
    func removeFromContains(word: String) {
        contains = contains.filter { $0 != word }
    }
    func removeFromNotContains(word: String) {
        notContains = notContains.filter { $0 != word }
    }
    
    func isFilterActive() -> Bool {
        if !keyWordsSearchArr.isEmpty { return true }
        if searchQuery != "" { return true }
        if duration != 0 { return true }
        if calories != 0 { return true }
        if !contains.isEmpty { return true }
        if !notContains.isEmpty { return true }
        return false
    }
    
    func findLocalRecents() {
        foundRecipesRecentsLocal = recentRecipes.filter({ $0.name.localizedStandardContains(searchQueryLocalRecents) })
    }
    
    func isSaved(recipe: RecipePreviewDTO) -> Bool {
        favoritesID = UserDefaults.standard.array(forKey: "favoritesID") as? [Int] ?? []
        if (favoritesID.contains(recipe.id)) {
            return true
        } else {
            return false
        }
    }
    func saveIdToFavorites(recipe: RecipePreviewDTO) {
        favoritesID = UserDefaults.standard.array(forKey: "favoritesID") as? [Int] ?? []
        if (!favoritesID.contains(recipe.id)) {
            favoritesID.append(recipe.id)
            UserDefaults.standard.set(favoritesID, forKey: "favoritesID")
        }
    }
    func deleteIdFromFavorites(recipe: RecipePreviewDTO) {
        favoritesID = UserDefaults.standard.array(forKey: "favoritesID") as? [Int] ?? []
        if (favoritesID.contains(recipe.id)) {
            favoritesID.removeAll { $0 == recipe.id }
            UserDefaults.standard.set(favoritesID, forKey: "favoritesID")
        }
    }
}
