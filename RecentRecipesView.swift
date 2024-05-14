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
    @Environment(\.presentationMode) var presentation
    @State var recentRecipes: [RecipePreviewDTO] = []
    @State var searchText = ""
    
    var body: some View {
            recipesView()
            .navigationTitle("recents.title".localized)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("", systemImage: "slider.horizontal.2.square") {
                            viewModel.modalFiltersIsOpenFromRecents = true
                        }
                        .sheet(isPresented: $viewModel.modalFiltersIsOpenFromRecents) {
                            Assembler.sharedAssembly
                                .resolver
                                .resolve(FiltersView.self)
                           }
                        .tint(.orange)
                    }
                }
                .searchable(text: $searchText)
                .searchPresentationToolbarBehavior(.avoidHidingContent)
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
                Text("recents.zero.message".localized)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor.systemGray3))
                    .font(.title2)
                    .padding(.bottom, 4)
                Button {
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Text("recents.torecipes.button".localized)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 30)
        } else {
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
    }
}

