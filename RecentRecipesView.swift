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
    
    var body: some View {
            recipesView()
            .navigationTitle("recents.title".localized)
            .navigationBarTitleDisplayMode(.inline)
            .tint(.orange)
            .searchable(text: $viewModel.searchQueryLocalRecents)
            .refreshable {
                viewModel.isLoadingRecents = true
                viewModel.loadRecents()
            }
            .onChange(of: viewModel.searchQueryLocalRecents) { _, _ in
                viewModel.findLocalRecents()
            }
            .onSubmit(of: .search) {
                viewModel.findLocalRecents()
            }
    }
    
    
    
    @ViewBuilder
    func recipesView() -> some View {
        if (viewModel.isLoadingRecents) {
            ProgressView()
        } else {
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
                if (viewModel.searchQueryLocalRecents == "") {
                    ScrollView() {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.recentRecipes, id: \.self) { recipe in
                                Assembler.sharedAssembly
                                    .resolver
                                    .resolve(RecipeBigCardView.self, argument: recipe)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .contentMargins(.horizontal, 12)
                } else {
                    if (viewModel.foundRecipesRecentsLocal.isEmpty) {
                        Text("allrecipes.errorFound.message".localized)
                    } else {
                        ScrollView() {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.foundRecipesRecentsLocal, id: \.self) { recipe in
                                    Assembler.sharedAssembly
                                        .resolver
                                        .resolve(RecipeBigCardView.self, argument: recipe)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        .contentMargins(.horizontal, 12)
                    }
                }
            }
        }
    }
}

