//
//  CookToTimeView.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 19.04.2024.
//

import SwiftUI
import Swinject

struct CookToTimeView: View {
    @StateObject var viewModel: RecipesViewModel
    
    var body: some View {
        recipesView()
            .refreshable(action: {
                if viewModel.searchQueryToTime == "" {
                    viewModel.isLoading = true
                    viewModel.loadToTimeRecipes()
                } else {
                    viewModel.isLoading = true
                    viewModel.findRecipesToTime()
                }
                        })
            .onAppear() {
                viewModel.loadToTimeRecipes()
            }
            .navigationTitle((viewModel.type ?? .breakfast).title)
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("", systemImage: "slider.horizontal.2.square") {
//                        viewModel.modalFiltersIsOpenFromTime = true
//                    }
//                    .sheet(isPresented: $viewModel.modalFiltersIsOpenFromTime) {
//                        Assembler.sharedAssembly
//                            .resolver
//                            .resolve(FiltersView.self)
//                    }
//                    .tint(.orange)
//                }
//            }
            .searchable(text: $viewModel.searchQueryToTime)
            .searchPresentationToolbarBehavior(.avoidHidingContent)
            .onChange(of: viewModel.searchQueryToTime, { _, _ in
                viewModel.isLoading = true
            })
            .onSubmit(of: .search) {
                viewModel.findRecipesToTime()
            }
            .onDisappear(perform: {
                viewModel.searchQueryToTime = ""
                viewModel.recipesForTime = []
            })
    }
    @ViewBuilder
    func recipesView() -> some View {
        if (viewModel.isLoading) {
            ProgressView()
        } else {
            if (viewModel.searchQueryToTime == "") {
                if (!viewModel.recipesForTime.isEmpty) {
                    GeometryReader {proxy in
                        ScrollView() {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.recipesForTime, id: \.self) { recipe in
                                    RecipeBigCardView(recipe: recipe, proxy: proxy)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        .contentMargins(.horizontal, 12)
                    }
                }
                else {
                    Text("cooktotime.error.message".localized)
                }
            } else {
                if (!viewModel.foundRecipesToTime.isEmpty) {
                    GeometryReader {proxy in
                        ScrollView() {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.foundRecipesToTime, id: \.self) { recipe in
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
