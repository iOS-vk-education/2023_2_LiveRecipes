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
                .navigationTitle("Мои рецепты")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("", systemImage: "gear") {
                            print("hello")
                        }
                    }
                }
                .searchable(text: $searchText)
    }
    @ViewBuilder
    func myRecipesView() -> some View {
        if (viewModel.myRecipes.isEmpty) {
            
        } else {
            
        }
    }
}
