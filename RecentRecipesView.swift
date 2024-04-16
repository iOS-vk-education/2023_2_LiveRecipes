//
//  RecentRecipesView.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 30.03.2024.
//

import SwiftUI
import Swinject

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
                        Button("", systemImage: "slider.horizontal.2.square") {
                            viewModel.modalFiltersIsOpen = true
                        }
                        .sheet(isPresented: $viewModel.modalFiltersIsOpen) {
                            Assembler.sharedAssembly
                                .resolver
                                .resolve(FiltersView.self)
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
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.recentRecipes) { recipe in
                            RecipeBigCardView(recipe: recipe, proxy: proxy)
                        }
                    }
                }
                
                .scrollIndicators(.hidden)
                .contentMargins(.horizontal, 12)
            }
        }
    }
}

