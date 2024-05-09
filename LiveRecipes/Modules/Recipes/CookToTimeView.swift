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
    var type: NameToTime
    
    var body: some View {
            recipesView()
            .onAppear() {
                viewModel.loadToTimeRecipes(chosenOption: type)
            }
            .navigationTitle(type.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("", systemImage: "slider.horizontal.2.square") {
                            viewModel.modalFiltersIsOpenFromTime = true
                        }
                        .sheet(isPresented: $viewModel.modalFiltersIsOpenFromTime) {
                            Assembler.sharedAssembly
                                .resolver
                                .resolve(FiltersView.self)
                           }
                        .tint(.orange)
                    }
                }
                .searchable(text: $viewModel.searchQuery)
    }
    
    @ViewBuilder
    func recipesView() -> some View {
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
    }
}
