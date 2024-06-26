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
                        .onAppear {
                            viewState.loadData()
                        }
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
            .toolbar(.visible, for: .tabBar)
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
            .searchable(text: $viewState.query)
            .onChange(of: viewState.query) { _, _ in
                viewState.findFavorites()
            }
            .onSubmit(of: .search) {
                viewState.findFavorites()
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func recipesView() -> some View {
        if viewState.query == "" {
            if (!viewState.favoriteRecipes.isEmpty) {
                GeometryReader {proxy in
                    ScrollView() {
                        LazyVStack(spacing: 12) {
                            ForEach(viewState.favoriteRecipes, id: \.self) { recipe in
                                Assembler.sharedAssembly
                                    .resolver
                                    .resolve(RecipeBigCardView.self, arguments: recipe.recipePreviewDTO, true, false)
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
        } else {
            if viewState.foundRecipes.isEmpty {
                Text("allrecipes.errorFound.message".localized)
            } else {
                GeometryReader {proxy in
                    ScrollView() {
                        LazyVStack(spacing: 12) {
                            ForEach(viewState.foundRecipes, id: \.self) { recipe in
                                Assembler.sharedAssembly
                                    .resolver
                                    .resolve(RecipeBigCardView.self, arguments: recipe.recipePreviewDTO, true, false)
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
