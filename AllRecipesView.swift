//
//  AllRecipesView.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 30.03.2024.
//

import SwiftUI
import Swinject

struct AllRecipesView: View {
    @StateObject var viewModel: RecipesViewModel
    
    var body: some View {
            recipesView()
            .navigationTitle("allrecipes.title".localized)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("", systemImage: "slider.horizontal.2.square") {
                            viewModel.modalFiltersIsOpenFromAll = true
                        }
                        .sheet(isPresented: $viewModel.modalFiltersIsOpenFromAll) {
                            Assembler.sharedAssembly
                                .resolver
                                .resolve(FiltersView.self)
                           }
                        .tint(.orange)
                    }
                }
                .searchable(text: $viewModel.searchQuery, isPresented: $viewModel.searchIsActive)
                .onSubmit(of: .search) {
                    viewModel.findRecipes()
                }
    }
    
    @ViewBuilder
    func recipesView() -> some View {
        if (viewModel.searchQuery == "") {
            if (!viewModel.allRecipes.isEmpty) {
                GeometryReader {proxy in
                    ScrollView() {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.allRecipes) { recipe in
                                RecipeBigCardView(recipe: recipe, proxy: proxy)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: $viewModel.scrollID)
                    .onChange(of: viewModel.scrollID) { oldValue, newValue in
                        viewModel.loadMoreAllRecipes()
                    }
                    .scrollIndicators(.hidden)
                    .contentMargins(.horizontal, 12, for: .scrollContent)
                    .padding(.bottom, 12)
                }
            }
            else {
                Text("allrecipes.error.message".localized)
            }
        }
            
        else {
            if (!viewModel.foundRecipes.isEmpty) {
                GeometryReader {proxy in
                    ScrollView() {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.foundRecipes, id: \.self) { recipe in
                                RecipeBigCardView(recipe: recipe, proxy: proxy)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .contentMargins(.horizontal, 12)
                }
            }
            else {
                Text("allrecipes.errorFound.message".localized)
            }
        }
    }
}
