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
                        }
                        .onTapGesture {
                            print(recipe.title)
                        }
                        HStack {
                            TextField("Еще компонент", text: $textNewItem)
                                .font(.body)
                                .foregroundColor(textNewItem.isEmpty ? Color.gray : Color.black)
                                .onSubmit({
                                    print("Окончание ввода: \(textNewItem)")
                                })
                        }
                    }.onDelete(perform: { indexSet in
                        print("try to delete")
                        print("indexSet:  \(indexSet)")
                        for index in indexSet {
                            print("index:  \(index)")
                            let recipeId = viewState.recipesList[index].id
                            let recipeTitle = viewState.recipesList[index].title
                            print("Deleting recipe with ID: \(recipeId)")
                            print("Deleting recipe with recipeTitle: \(recipeTitle)")
                            //viewState.recipesList.remove(atOffsets: indexSet)
                        }
                        //viewState.recipesList.remove(atOffsets: indexSet)
                    })
                    HStack {
                        TextField("Введите значение", text: $textNewRecipe)
                            .font(.body)
                            .foregroundColor(textNewRecipe.isEmpty ? Color.gray : Color.black)
                            .onSubmit({
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
    /*var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewState.menuItems, id: \.id) { dish in
                        HStack {
                            Image(systemName: "star").padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 60))
                            Text(dish.title)
                        }.onTapGesture {
                            print(dish.title)
                        }
                    }.onDelete(perform: { indexSet in
                        print("try to delete")
                        viewState.menuItems.remove(atOffsets: indexSet)
                    })
                }.listStyle(.grouped)
            }.navigationTitle("Список покупок")
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
    }*/
}

#Preview {
    ApplicationViewBuilder.stub.build(view: .list)
}
