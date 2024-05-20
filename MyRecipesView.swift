//
//  MyRecipesView.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 30.03.2024.
//

import SwiftUI
import Swinject
import Foundation

struct MyRecipesView: View {
    @StateObject var viewModel: RecipesViewModel
    @State private var searchText = ""
    
    var body: some View {
            myRecipesView()
                .scrollIndicators(.hidden)
                .navigationTitle("myrecipes.title".localized)
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText)
                .searchPresentationToolbarBehavior(.avoidHidingContent)
                .onAppear {
                    viewModel.findMyRecipes()
                }
    }
    @ViewBuilder
    func myRecipesView() -> some View {
        if (viewModel.myRecipes.isEmpty) {
            VStack {
                Image(systemName: "archivebox")
                    .resizable()
                    .frame(width: 180, height: 155)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor.systemGray3))
                    .padding(.bottom, 0)
                Text("myrecipes.zero.message".localized)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor.systemGray3))
                    .font(.title2)
                    .padding(.bottom, 4)
                NavigationLink {
                    Assembler.sharedAssembly
                        .resolver
                        .resolve(CreationView.self)
                } label: {
                    HStack {
                        Text("myrecipes.tocreation".localized)
                            .font(.headline)
                        Image(systemName: "plus.app")
                    }
                }

            }
            .padding(.bottom, 30)
        } else {
            ScrollView() {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.myRecipes, id: \.self) { recipe in
                        Assembler.sharedAssembly
                            .resolver
                            .resolve(RecipeBigCardView.self, arguments: recipe.recipePreviewDTO, true, true)
                            .contextMenu(menuItems: {
                                Button("Delete", systemImage: "trash") {
                                    withAnimation(.spring()) {
                                        viewModel.deleteMyRecipe(id: recipe.id ?? 0)
                                        viewModel.findMyRecipes()
                                    }
                                }
                            })
                    }
                }
                Button(action: {}) {
                    NavigationLink(destination: {
                    Assembler.sharedAssembly
                        .resolver
                        .resolve(CreationView.self)
                    })
                    {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(.orange)
                            .clipShape(.circle)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, 12)
        }
    }
}
