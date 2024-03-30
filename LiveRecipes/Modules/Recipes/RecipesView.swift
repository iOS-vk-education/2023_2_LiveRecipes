//
//  RecipesView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import SwiftUI

struct RecipesView: View {
    @StateObject var viewModel: RecipesViewModel

    var body: some View {
        VStack {
            NavigationStack {
                ScrollView(showsIndicators: false) {
                    if !viewModel.foundRecipes.isEmpty {
                        ForEach(viewModel.foundRecipes, id: \.self) { recipe in
                            Text(recipe.title).padding()
                        }
                    } else {
                        Text("recipes.havent.load")
                    }
                }
                .refreshable(action: {
                    viewModel.findRecipes()
                })
                .frame(maxWidth: .infinity)
                .navigationTitle(Tabs.recipes.tabName)

            }
            .searchable(text: $viewModel.searchQuery, isPresented: $viewModel.searchIsActive)
            .onSubmit(of: .search) { viewModel.findRecipes() }
        }
    }
}

#Preview {
    ApplicationViewBuilder.stub.build(view: .recipes)
}
