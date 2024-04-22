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
                        Button("", systemImage: "slider.horizontal.2.square") {
                            viewModel.modalFiltersIsOpenFromMy = true
                        }
                        .sheet(isPresented: $viewModel.modalFiltersIsOpenFromMy) {
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
    func myRecipesView() -> some View {
        if (viewModel.myRecipes.isEmpty) {
            VStack {
                Image(systemName: "archivebox")
                    .resizable()
                    .frame(width: 180, height: 155)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor.systemGray3))
                    .padding(.bottom, 0)
                Text("Тут пока ничего нет")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor.systemGray3))
                    .font(.title2)
                    .padding(.bottom, 4)
                NavigationLink {
                    Assembler.sharedAssembly
                        .resolver
                        .resolve(CreationView.self)
                } label: {
                    Text("К созданию")
                }

            }
            .padding(.bottom, 30)
        } else {
            GeometryReader {proxy in
                ScrollView() {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.myRecipes) { recipe in
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
