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
    @State private var searchText = ""
    var title: String
    
    var body: some View {
            recipesView()
            .navigationTitle(title)
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
        .searchable(text: $searchText)
    }
    
    @ViewBuilder
    func recipesView() -> some View {
        if (!viewModel.allRecipes.isEmpty) {
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
            Text("cooktotime.error.message".localized)
        }
    }
}
