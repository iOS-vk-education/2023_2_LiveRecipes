//
//  RecipesViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Combine
import Foundation
import SwiftUI

final class RecipesViewModel: ObservableObject, RecipesViewModelProtocol {
    var model: RecipesModelProtocol
    var coreData = RecipeDataManager.shared
    
    //результаты поиска
    @Published var foundRecipes: [RecipePreviewDTO] = []
    @Published var foundRecipesToTime: [RecipePreviewDTO] = []
    @Published var foundRecipesRecentsLocal: [RecipePreviewDTO] = []
    @Published var foundRecipesMyLocal: [Dish] = []
    
    //поиск
    @Published var searchQuery = ""
    @Published var searchQueryAll = ""
    @Published var searchQueryToTime = ""
    @Published var searchQueryLocalRecents = ""
    @Published var searchQueryLocalMy = ""
    @Published var searchIsActive = false
    @Published var searchIsActiveAll = false
    
    //cook to time block
    @Published var type: NameToTime?
    @Published var isEmptyFoundToTime = false
    @Published var isEmptyToTime = false
    
    //фильтры
    @Published var filtersIsActive = false
    @Published var keyWordsSearchArr: [String] = []
    @Published var duration: String = ""
    @Published var calories: String = ""
    @Published var isMoreCalories: Bool = false
    @Published var fats: String = ""
    @Published var isMoreFats: Bool = false
    @Published var protein: String = ""
    @Published var isMoreProtein: Bool = false
    @Published var carbohydrates: String = ""
    @Published var isMoreCarbohydrates: Bool = false
    @Published var containsTextField: String = ""
    @Published var notContainsTextField: String = ""
    @Published var contains: [String] = []
    @Published var notContains: [String] = []
    @Published var isTimeSetting: Bool = false
    @Published var minutes: Int = 0
    @Published var hours: Int = 0
    @Published var isTimeSetted: Bool = false
    var temp: CGFloat = 0
    
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
    @Published var myRecipes: [Dish] = []
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
        findMyRecipes()
    }
    
    func deleteMyRecipe(id: Int) -> Void {
        RecipeDataManager.shared.delete(recipeMyId: id) { _ in }
    }
    
    func findMyRecipes() {
        myRecipes = model.getMyRecipes()
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
        if arrayOfRecentsID.isEmpty {
            isLoadingRecents = false
            return
        }
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
        model.findRecipesByFilter(query: searchQuery, keyWords: keyWordsSearchArr, duration: duration, calories: calories, protein: protein, fats: fats, carb: carbohydrates, isMoreCal: isMoreCalories, isMoreProt: isMoreProtein, isMoreFats: isMoreFats, isMoreCarb: isMoreCarbohydrates, contains: contains, notContains: notContains) { [weak self] result in
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
        if duration != "" { return true }
        if calories != "" { return true }
        if fats != "" { return true }
        if carbohydrates != "" { return true }
        if protein != "" { return true }
        if !contains.isEmpty { return true }
        if !notContains.isEmpty { return true }
        return false
    }
    
    func findLocalRecents() {
        foundRecipesRecentsLocal = recentRecipes.filter({ $0.name.localizedStandardContains(searchQueryLocalRecents) })
    }
    func findLocalMy() {
        foundRecipesMyLocal = myRecipes.filter({ $0.title.localizedStandardContains(searchQueryLocalMy) })
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
    func saveToCoreDataFavorites(recipe: RecipePreviewDTO) {
        model.findRecipeForCoreData(id: recipe.id) { [weak self] result in
            guard let data = Data(base64Encoded: recipe.photo) else { return }
            let image = UIImage(data: data)
            var dishComposition: [DishComposition] = []
            for i in result.ingredients.indices {
                dishComposition.append(DishComposition(id: i,
                                                       product: result.ingredients[i],
                                                       quantity: ""))
            }
            var dishSteps: [DishStep] = []
            for i in result.steps.indices {
                guard let datastep = Data(base64Encoded: result.steps[i][1]) else { return }
                let imagestep = UIImage(data: datastep)
                dishSteps.append(DishStep(id: i,
                                          stepTime: Int(result.steps[i][2]) ?? 0,
                                          description: result.steps[i][0],
                                          photo: imagestep))
            }
            self?.coreData.create(id: result.id,dish: Dish(id: result.id,
                                             title: result.name,
                                             description: result.description,
                                             photo: image,
                                             timeToPrepare: result.duration,
                                             nutritionValue: Nutrition(bzy: result.bzy),
                                             dishComposition: dishComposition,
                                             dishSteps: dishSteps)) {
                print("success")
                self?.showRecipesInDB()//////////////////////////////////////////////
            }
        }
    }
    func deleteFromCoreDataFavorites(recipe: RecipePreviewDTO) {
        coreData.delete(recipeNetId: recipe.id) {[weak self] _ in
            print("sucksess")
            self?.showRecipesInDB()//////////////////////////////////////////////////
        }
    }
    func deleteFromCoreDataFavoritesFromFavoritesView(recipe: RecipePreviewDTO) {
        favoritesID = UserDefaults.standard.array(forKey: "favoritesID") as? [Int] ?? []
        coreData.fetch { dishes in
            for dish in dishes {
                if recipe.id == dish.id {
                    if let index = self.favoritesID.firstIndex(of: dish.netId) {
                        self.favoritesID.remove(at: index)
                        UserDefaults.standard.setValue(self.favoritesID, forKey: "favoritesID")
                    }
                    break
                }
            }
        }
        
        coreData.delete(recipeMyId: recipe.id) { [weak self] _ in
            print("sucksess")
            self?.showRecipesInDB()
        }
    }
    func durationSet() {
        duration = "\(hours * 60 + minutes)"
    }
    func getSizeOfElement(proxy: GeometryProxy) {
        temp = proxy.size.width
    }
    func showRecipesInDB() {
        print("----------------------------")
        print("[DEBUG] begin")
        RecipeDataManager.shared.fetch { dishes in
            print("[DEBUG] dishes:")
            for dish in dishes {
                print("---")
                print("id: \(dish.id)")
                print("netId: \(dish.netId)")
                print("title: \(dish.title)")
                print("description: \(dish.description)")
                print("timeToPrepare: \(dish.timeToPrepare)")
                print("photoRef: \(dish.photo == nil ? "NO" : "YES")")
                print("nutritionValueCal: \(dish.nutritionValue.calories)")
                print("nutritionValueProt: \(dish.nutritionValue.protein)")
                print("nutritionValueFats: \(dish.nutritionValue.fats)")
                print("nutritionValueCarb: \(dish.nutritionValue.carbohydrates)")
                print("---")
                for step in dish.dishSteps {
                    print("---")
                    print("step.id: \(step.id)")
                    print("step.title: \(step.stepTime)")
                    print("step.description: \(step.description)")
                    print("step.photo: \(step.photo == nil ? "NO" : "YES")")
                }
                for composition in dish.dishComposition {
                    print("---")
                    print("composition.id: \(composition.id)")
                    print("composition.product: \(composition.product)")
                    print("composition.quantity: \(composition.quantity)")
                }
            }
        }
        print("[DEBUG] end")
        print("----------------------------")
    }
}
