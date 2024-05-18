//
//  FavoritesView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import SwiftUI
import Swinject

struct FavoritesView: View {
    @StateObject var viewState: FavoritesViewModel
    
    @State private var searchText = ""
    @State private var selectedSegment = 0
    
    let segments = ["favorites".localized, "favorites.myRecipes".localized]
    var body: some View {
        NavigationView {
            VStack {
                    Picker(selection: $selectedSegment, label: Text("Select a segment")) {
                        ForEach(0..<2) { index in
                            Text(self.segments[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                if selectedSegment == 0 {
                    Spacer()
                    recipesView()
                    Spacer()
                }
                else {
                    Spacer()
                    Assembler.sharedAssembly
                        .resolver
                        .resolve(MyRecipesView.self)
                    Spacer()
                }
            }
            .navigationTitle(Tabs.favorites.tabName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink (destination: {
                            Assembler.sharedAssembly
                                .resolver
                                .resolve(SettingsView.self)
                        }, label: {Image(systemName: "gear")})
                    }
                }
            .searchable(text: $searchText)
            
        }
    }
    
    @ViewBuilder
    func recipesView() -> some View {
        if (!viewState.favoriteRecipes.isEmpty) {
            GeometryReader {proxy in
                ScrollView() {
                    LazyVStack(spacing: 12) {
                        ForEach(viewState.favoriteRecipes, id: \.self) { recipe in
                            RecipeBigCardView(recipe: recipe.recipePreviewDTO)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .contentMargins(.horizontal, 12)
            }
        }
        else {
            Image(systemName: "star.slash.fill")
                .resizable()
                .frame(width: 180, height: 155)
                .fontWeight(.semibold)
                .foregroundStyle(Color(UIColor.systemGray3))
                .padding(.bottom, 0)
            Text("favorites.favorites.isEmpty".localized)
                .fontWeight(.semibold)
                .foregroundStyle(Color(UIColor.systemGray3))
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.bottom, 4)
        }
    }
}

