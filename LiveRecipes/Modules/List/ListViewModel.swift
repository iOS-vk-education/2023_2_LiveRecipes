//
//  ListViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

struct Recipe {
    var id: Int
    var title: String
    var item: [RecipeItem]
}
struct RecipeItem {
    var id: Int
    var title: String
}

final class ListViewModel: ObservableObject, ListViewModelProtocol {
    var model: ListModelProtocol
    var counter: Int = 7
    var timer: Timer?
    @Published var recipesList: [Recipe] = [
        Recipe(id: 0, title: "Хреновины-0", item: [
            RecipeItem(id: 0, title: "Хрень-0"),
            RecipeItem(id: 1, title: "Хрень-1"),
            RecipeItem(id: 2, title: "Хрень-2")
        ]),
        Recipe(id: 1, title: "Хреновины-1", item: [
            RecipeItem(id: 0, title: "Хрень-0"),
            RecipeItem(id: 1, title: "Хрень-1"),
            RecipeItem(id: 2, title: "Хрень-2"),
            RecipeItem(id: 3, title: "Хрень-3"),
            RecipeItem(id: 4, title: "Хрень-4")
        ]),
        Recipe(id: 2, title: "Хреновины-2", item: [
            RecipeItem(id: 0, title: "Хрень-0")
        ]),
        Recipe(id: 3, title: "Хреновины-3", item: [
            RecipeItem(id: 0, title: "Хрень-0"),
            RecipeItem(id: 1, title: "Хрень-1"),
            RecipeItem(id: 2, title: "Хрень-2"),
            RecipeItem(id: 3, title: "Хрень-3"),
            RecipeItem(id: 4, title: "Хрень-4")
        ]),
        Recipe(id: 4, title: "Хреновины-4", item: [
            RecipeItem(id: 0, title: "Хрень-0"),
            RecipeItem(id: 1, title: "Хрень-1"),
            RecipeItem(id: 2, title: "Хрень-2")
        ]),
        Recipe(id: 5, title: "Хреновины-5", item: [
            RecipeItem(id: 0, title: "Хрень-0"),
            RecipeItem(id: 1, title: "Хрень-1"),
            RecipeItem(id: 2, title: "Хрень-2"),
            RecipeItem(id: 3, title: "Хрень-3")
        ]),
        Recipe(id: 6, title: "Хреновины-6", item: [
            RecipeItem(id: 0, title: "Хрень-0"),
            RecipeItem(id: 1, title: "Хрень-1")
        ])
    ]
    init(recipesModel: ListModelProtocol) {
        self.model = recipesModel
        //self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(addItemToMenu), userInfo: nil, repeats: true)
    }
    @objc
    func addItemToMenu() {
        recipesList.append(Recipe(id: counter, title: "Хрень-\(String(counter))", item: []))
        counter += 1
        print("counter = \(counter)")
        print("menuItems.count = \(recipesList.count)")
    }
}
