//
//  RecentRecipesView.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 30.03.2024.
//

import SwiftUI

struct RecentRecipesView: View {
    @StateObject var viewModel: RecipesViewModel
    @State var recentRecipes: [Recipe] = []
    @State var searchText = ""
    
    var body: some View {
            recipesView()
                .navigationTitle("Недавние")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("", systemImage: "gear") {
                            print("hello")
                        }
                        .tint(.orange)
                    }
                }
                .searchable(text: $searchText)
        .tint(.orange)
    }
    
    
    
    @ViewBuilder
    func recipesView() -> some View {
        if (viewModel.recentRecipes.isEmpty) {
            VStack {
                Image(systemName: "clock.badge.questionmark")
                    .resizable()
                    .frame(width: 180, height: 155)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor.systemGray3))
                    .padding(.bottom, 0)
                    .padding(.leading, 25)
                Text("Тут пока ничего нет")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor.systemGray3))
                    .font(.title2)
                    .padding(.bottom, 4)
                Button {
                    print("К рецептам")
                } label: {
                    Text("К рецептам")
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 30)
        } else {
            GeometryReader {proxy in
                ScrollView() {
                    VStack(spacing: 12) {
                        ForEach(viewModel.recentRecipes) { recipe in
                            VStack (spacing: 0) {
                                Image(recipe.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: proxy.size.width - 24, height: 170)
                                    .clipped()
                                VStack (spacing: 3) {
                                    HStack (spacing: 3) {
                                        Text(recipe.name)
                                            .fontWeight(.medium)
                                            .font(.system(size: 11))
                                        Spacer()
                                        Image(systemName: "clock")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 9, height: 9)
                                            .tint(.secondary)
                                        Text(recipe.time + " мин")
                                            .font(.system(size: 10))
                                    }
                                    .padding(.horizontal, 8)
                                    HStack {
                                        Text(recipe.cathegory)
                                            .fontWeight(.light)
                                            .foregroundStyle(Color(uiColor: .darkGray))
                                            .font(.system(size: 10))
                                        Spacer()
                                        Text(recipe.isInFavorites ? "В избранном" : "Добавить в избранное")
                                            .foregroundStyle(recipe.isInFavorites ? Color.yellow : Color.blue)
                                            .font(.system(size: 10))
                                            .fontWeight(.light)
                                    }
                                    .padding(.horizontal, 8)
                                }
                                .frame(width: proxy.size.width - 24, height: 40)
                            }
                            .frame(width: proxy.size.width - 24, height: 212)
                            .background(Color(UIColor.secondarySystemBackground))
                            .clipShape(.rect(cornerRadius: 8))
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .contentMargins(.horizontal, 12)
            }
        }
    }
}

