//
//  ListView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//
import SwiftUI


struct ListView: View {
    
    @StateObject var viewState: ListViewModel
    @State private var textNewRecipe = ""
    @State private var textNewItem = ""
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewState.recipesList, id: \.id) { recipe in
                        HStack {
                            Text(recipe.title.uppercased())
                                .font(.title3)
                                .foregroundColor(Color(.gray))
                        }
                        ForEach(recipe.item, id: \.id) { item in
                            HStack {
                                Text(item.title).font(.title3)
                                    .font(.body)
                            }
                        }.onDelete(perform: { indexSetItem in
                            for index in indexSetItem {
                                print("1-Deleting recipe with ID: \(viewState.recipesList[index].id)")
                                print("1-Deleting recipe with recipeTitle: \(viewState.recipesList[index].title)")
                                //viewState.recipesList.remove(atOffsets: indexSet)
                            }
                            //viewState.recipesList.remove(atOffsets: indexSet)
                        })
                        .onTapGesture {
                            print("Tapped item of resipy: \(recipe.title) with id: \(recipe.id)")
                        }
                        HStack {
                            TextField("Введите продукт", text: $textNewItem)
                                .font(.body)
                                .foregroundColor(textNewItem.isEmpty ? Color.gray : Color.black)
                                .onSubmit({
                                    print("Окончание ввода: \(textNewItem) в список с id: \(recipe.id)")
                                })
                        }
                    }.onDelete(perform: { indexSetRecipe in
                        for index in indexSetRecipe {
                            print("2-Deleting recipe with ID: \(viewState.recipesList[index].id)")
                            print("2-Deleting recipe with recipeTitle: \(viewState.recipesList[index].title)")
                            //viewState.recipesList.remove(atOffsets: indexSet)
                        }
                        //viewState.recipesList.remove(atOffsets: indexSet)
                    })
                    .onTapGesture {
                        print("Tapped some resipy")
                    }
                    HStack {
                        TextField("Создать список", text: $textNewRecipe)
                            .font(.body)
                            .foregroundColor(textNewRecipe.isEmpty ? Color.gray : Color.black)
                            .onSubmit({
                                CoreDataManager.shared.create(entityName: "ListRecipeEntity") { recipe in
                                    guard let recipe = recipe as? ListRecipeEntity else {
                                        return
                                    }
                                    let countRecipes = CoreDataManager.shared.count(request: ListRecipeEntity.fetchRequest())
                                    var resultStr = "Count objects: \(countRecipes )\n\n"
                                    let newRecipeId = Int64(countRecipes + 1)
                                    recipe.id = newRecipeId
                                    recipe.title = textNewRecipe
                                    DispatchQueue.main.async {
                                        viewState.recipesList.append(Recipe(id: Int(newRecipeId), title: textNewRecipe, item: []))
                                        textNewRecipe = ""
                                    }
                                }
                                print("Окончание ввода: \(textNewRecipe)")
                            })
                    }
                    
                }.listStyle(.grouped)
            }.navigationTitle("tab.list")
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: { print("1") }, label: {
                            Text("Назад")
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: { print("2") }, label: {
                            Image(systemName: "key")
                        })
                    }
                }
        }
    }
}

#Preview {
    ApplicationViewBuilder.stub.build(view: .list)
}
