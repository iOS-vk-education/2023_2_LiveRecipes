//
//  RecipesView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import SwiftUI

struct RecipesView: View {
    @StateObject var viewState: RecipesViewModel
    @State private var searchText = ""
    @State var keyWords: [KeyWord] = []
    @State var allRecipes: [Recipe] = []
    @State var recentRecipes: [Recipe] = []
    @State var myRecipes: [Recipe] = []
    @State var isLoading = false
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    keyWordsView()
                        .onAppear {
                            Task {
                                isLoading = true
                                keyWords = try await loadKeyWords()
                                isLoading = false
                            }
                        }
                    allRecipesView()
                        .onAppear {
                            Task {
                                isLoading = true
                                allRecipes = try await loadAllRecipes()
                                isLoading = false
                            }
                        }
                    cookToTimeView()
                    recentRecipesView()
                        .onAppear {
                            Task {
                                isLoading = true
                                recentRecipes = try await loadRecentRecipes()
                                isLoading = false
                            }
                        }
                    myRecipesView()
                        .onAppear {
                            Task {
                                isLoading = true
                                myRecipes = try await loadMyRecipes()
                                isLoading = false
                            }
                        }
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle(Tabs.recipes.tabName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "gear") {
                        print("hello")
                    }
                    .tint(.orange)
                }
            }
        }
        .searchable(text: $searchText)
        .tint(.orange)
    }
    
    @ViewBuilder
    func keyWordsView() -> some View {
        titleButtonOfBlock(blockName: "Найти по ключевым словам")
        ScrollView (.horizontal) {
            HStack {
                ForEach (keyWords.indices, id: \.self) { index in
                    Button(action: {
                        keyWords[index].choose()
                    }, label: {
                        Text(keyWords[index].keyWord)
                            .tint(keyWords[index].isChoosed ? .white : .black)
                            .font(.caption)
                            .fontWeight(keyWords[index].isChoosed ? .bold : .regular)
                    })
                    .padding(8)
                    .background(Color(keyWords[index].isChoosed ? UIColor.orange : UIColor.secondarySystemBackground))
                    .clipShape(.capsule)
                }
                Button(action: {
                    print("next view")
                }, label: {
                    HStack {
                        Text("Больше слов")
                            .tint(.black)
                            .font(.caption)
                        Image(systemName: "chevron.right")
                            .tint(.black)
                            .font(.caption)
                            .imageScale(.small)
                    }
                })
                .padding(8)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(.capsule)
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(.horizontal, 16)
    }
    
    @ViewBuilder
    func titleButtonOfBlock(blockName: String) -> some View {
        HStack {
            Text(blockName)
            Image(systemName: "chevron.right")
            .imageScale(.small)
            Spacer()
        }
            .tint(.black)
            .font(.title3)
            .fontWeight(.light)
            .padding(.leading, 20)
    }
    
    @ViewBuilder
    func allRecipesView() -> some View {
        NavigationLink(destination: AllRecipesView(viewState: RecipesViewModel(recipesModel: RecipesModel())), label: {
            titleButtonOfBlock(blockName: "Рецепты")
        })
            .padding(.top, 8)
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach (allRecipes) { recipie in
                    VStack (spacing: 0) {
                        Image(recipie.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 220, height: 100)
                            .clipped()
                        VStack (spacing: 2) {
                            HStack (spacing: 3) {
                                Text(recipie.name)
                                    .fontWeight(.medium)
                                    .font(.system(size: 9))
                                Spacer()
                                Image(systemName: "clock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 7, height: 7)
                                    .tint(.secondary)
                                Text(recipie.time + " мин")
                                    .font(.system(size: 8))
                            }
                            .padding(.horizontal, 8)
                            HStack {
                                Text(recipie.cathegory)
                                    .fontWeight(.light)
                                    .foregroundStyle(Color(uiColor: .darkGray))
                                    .font(.system(size: 8))
                                Spacer()
                                Text(recipie.isInFavorites ? "В избранном" : "Добавить в избранное")
                                    .foregroundStyle(recipie.isInFavorites ? Color.yellow : Color.blue)
                                    .font(.system(size: 8))
                                    .fontWeight(.light)
                            }
                            .padding(.horizontal, 8)
                        }
                        .frame(width: 220, height: 35)
                    }
                    .frame(width: 220, height: 135)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(.rect(cornerRadius: 8))
                }
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(.horizontal, 12)
    }
    
    @ViewBuilder
    func cookToTimeView() -> some View {
        VStack {
            HStack {
                Text("Приготовьте ко времени")
                    .tint(.black)
                    .font(.title3)
                    .fontWeight(.light)
                    .padding(.leading, 20)
                    .padding(.top, 8)
                Spacer()
            }
            GeometryReader {proxy in
                HStack(spacing: (proxy.size.width - 320 - 12)/5) {
                    VStack {
                        Image("cesar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(.rect(cornerRadius: 8))
                            .clipped()
                        Text("Завтрак")
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                    VStack {
                        Image("cesar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(.rect(cornerRadius: 8))
                            .clipped()
                        Text("Обед")
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                    VStack {
                        Image("cesar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(.rect(cornerRadius: 8))
                            .clipped()
                        Text("Ужин")
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                    VStack {
                        Image("cesar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(.rect(cornerRadius: 8))
                            .clipped()
                        Text("Перекус")
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                }
                .padding(.horizontal, (proxy.size.width - 320 + 12)/5)
            }
            .frame(height: 96)
            
        }
    }
    
    @ViewBuilder
    func recentRecipesView() -> some View {
        titleButtonOfBlock(blockName: "Недавние")
            .padding(.top, 8)
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach (recentRecipes) { recipe in
                    VStack (spacing: 0) {
                        Image(recipe.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 220, height: 100)
                            .clipped()
                        VStack (spacing: 2) {
                            HStack (spacing: 3) {
                                Text(recipe.name)
                                    .fontWeight(.medium)
                                    .font(.system(size: 9))
                                Spacer()
                                Image(systemName: "clock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 7, height: 7)
                                    .tint(.secondary)
                                Text(recipe.time + " мин")
                                    .font(.system(size: 8))
                            }
                            .padding(.horizontal, 8)
                            HStack {
                                Text(recipe.cathegory)
                                    .fontWeight(.light)
                                    .foregroundStyle(Color(uiColor: .darkGray))
                                    .font(.system(size: 8))
                                Spacer()
                                Text(recipe.isInFavorites ? "В избранном" : "Добавить в избранное")
                                    .foregroundStyle(recipe.isInFavorites ? Color.yellow : Color.blue)
                                    .font(.system(size: 8))
                                    .fontWeight(.light)
                            }
                            .padding(.horizontal, 8)
                        }
                        .frame(width: 220, height: 35)
                    }
                    .frame(width: 220, height: 135)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(.rect(cornerRadius: 8))
                }
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(.horizontal, 12)
    }
    
    @ViewBuilder
    func myRecipesView() -> some View {
        titleButtonOfBlock(blockName: "Мои рецепты")
            .padding(.top, 8)
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach (myRecipes) { recipe in
                    VStack (spacing: 0) {
                        Image(recipe.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 220, height: 100)
                            .clipped()
                        VStack (spacing: 2) {
                            HStack (spacing: 3) {
                                Text(recipe.name)
                                    .fontWeight(.medium)
                                    .font(.system(size: 9))
                                Spacer()
                                Image(systemName: "clock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 7, height: 7)
                                    .tint(.secondary)
                                Text(recipe.time + " мин")
                                    .font(.system(size: 8))
                            }
                            .padding(.horizontal, 8)
                            HStack {
                                Text(recipe.cathegory)
                                    .fontWeight(.light)
                                    .foregroundStyle(Color(uiColor: .darkGray))
                                    .font(.system(size: 8))
                                Spacer()
                                Text(recipe.isInFavorites ? "В избранном" : "Добавить в избранное")
                                    .foregroundStyle(recipe.isInFavorites ? Color.yellow : Color.blue)
                                    .font(.system(size: 8))
                                    .fontWeight(.light)
                            }
                            .padding(.horizontal, 8)
                        }
                        .frame(width: 220, height: 35)
                    }
                    .frame(width: 220, height: 135)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(.rect(cornerRadius: 8))
                }
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(.horizontal, 12)
    }
}


//#Preview {
//    ApplicationViewBuilder.stub.build(view: .cooking)
//}
