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
            .refreshable(action: {
                if viewModel.searchQueryAll == "" {
                    viewModel.isLoading1 = true
                    viewModel.loadAllRecipes()
                } else {
                    viewModel.isLoading = true
                    viewModel.findRecipesAll()
                }
                        })
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
            .searchable(text: $viewModel.searchQueryAll, isPresented: $viewModel.searchIsActiveAll)
            .searchPresentationToolbarBehavior(.avoidHidingContent)
            .onChange(of: viewModel.searchQueryAll, { _, _ in
                viewModel.isLoading = true
            })
            .onSubmit(of: .search) {
                viewModel.findRecipesAll()
            }
            .onDisappear(perform: {
                viewModel.searchQueryAll = ""
            })
    }
    
    @ViewBuilder
    func recipesView() -> some View {
        if viewModel.isLoading || viewModel.isLoading1 {
            ProgressView()
        } else {
            if (viewModel.searchQueryAll == "") {
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
                        .onChange(of: viewModel.scrollID) { _, _  in
                            viewModel.loadMoreAllRecipes()
                        }
                        .scrollIndicators(.hidden)
                        .contentMargins(.horizontal, 12, for: .scrollContent)
                        .contentMargins(.bottom, 12, for: .scrollContent)
                    }
                }
                else {
                    Text("allrecipes.error.message".localized)
                }
            }
            else {
                if (!viewModel.foundRecipes.isEmpty) {
                    GeometryReader {proxy in
                        ScrollView {
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
}
