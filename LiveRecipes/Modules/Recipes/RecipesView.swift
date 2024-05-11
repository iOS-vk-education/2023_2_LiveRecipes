//
//  RecipesView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

//import Foundation
//import SwiftUI
//
//struct RecipesView: View {
//    @StateObject var viewModel: RecipesViewModel
//
//    var body: some View {
//        VStack {
//            NavigationStack {
//                ScrollView(showsIndicators: false) {
//                    if !viewModel.foundRecipes.isEmpty {
//                        ForEach(viewModel.foundRecipes, id: \.self) { recipe in
//                            Text(recipe.title).padding()
//                        }
//                    } else {
//                        Text("recipes.havent.load")
//                    }
//                }
//                .scrollIndicators(.hidden)
//                .navigationTitle(Tabs.recipes.tabName)
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem(placement: .topBarTrailing) {
//                        Button("", systemImage: "gear") {
//                            print("hello")
//                        }
//                    }
//                }
//            }
//            .refreshable(action: {
//                viewModel.findRecipes()
//            })
//            .searchable(text: $viewModel.searchQuery, isPresented: $viewModel.searchIsActive)
//            .onSubmit(of: .search) { viewModel.findRecipes() }
//        }
//    }
//}
//
//#Preview {
//    ApplicationViewBuilder.stub.build(view: .recipes)
//}

import Foundation
import SwiftUI
import Swinject

struct RecipesView: View {
    @StateObject var viewModel: RecipesViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView {
                    VStack {
                        keyWordsView()
                        if (viewModel.searchQuery == "") {
                            allRecipesView()
                            cookToTimeView()
                            recentRecipesView()
                            myRecipesView()
                        }
                        else {
                            LazyVStack {
                                ForEach (viewModel.foundRecipes) { recipe in
                                    RecipeBigCardView(recipe: recipe, proxy: proxy)
                                }
                            }
                        }
                    }
                }
                .contentMargins(.bottom, 12, for: .scrollContent)
                .scrollIndicators(.hidden)
            }
            .navigationTitle(Tabs.recipes.tabName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack (spacing: 4) {
                            NavigationLink (destination: {
                                Assembler.sharedAssembly
                                    .resolver
                                    .resolve(SettingsView.self)
                            }, label: {Image(systemName: "gear")})
                        Button("", systemImage: "slider.horizontal.2.square") {
                            viewModel.modalFiltersIsOpenFromMain = true
                        }
                        .sheet(isPresented: $viewModel.modalFiltersIsOpenFromMain) {
                            Assembler.sharedAssembly
                                .resolver
                                .resolve(FiltersView.self)
                           }
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
            .searchable(text: $viewModel.searchQuery, isPresented: $viewModel.searchIsActive)
            .onSubmit (of: .search) {
                viewModel.findRecipes()
            }
        .refreshable(action: {
                        print("refresh")
                    })
    }
    
    @ViewBuilder
    func keyWordsView() -> some View {
        if (viewModel.keyWords.isEmpty) {
            Text("recipes.keywords.error.message".localized)
        } else {
            Button  {
                viewModel.modalKeyWordsIsOpen = true
            } label: {
                titleButtonOfBlock(blockName: "recipes.keywords.button".localized)
            }.sheet(isPresented: $viewModel.modalKeyWordsIsOpen) {
                Assembler.sharedAssembly
                    .resolver
                    .resolve(KeyWordsView.self)
               }
            ScrollView (.horizontal) {
                LazyHStack {
                    ForEach (viewModel.keyWords.indices, id: \.self) { index in
                        Button(action: {
                            viewModel.keyWords[index].choose()
                            viewModel.sortKeyWordsByChoose()
                        }, label: {
                            Text(viewModel.keyWords[index].keyWord)
                                .tint(viewModel.keyWords[index].isChoosed ? .white : .black)
                                .font(.caption)
                        })
                        .padding(8)
                        .background(Color(viewModel.keyWords[index].isChoosed ? UIColor.orange : UIColor.secondarySystemBackground))
                        .clipShape(.capsule)
                    }
                    Button(action: {
                        print("next view")
                    }, label: {
                        HStack {
                            Text("recipes.keywords.more".localized)
                                .tint(.black)
                                .font(.caption)
                            Image(systemName: "chevron.right")
                                .tint(.black)
                                .font(.caption)
                                .imageScale(.small)
                        }
                    })
                    .padding(8)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(.capsule)
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    func titleButtonOfBlock(blockName: String) -> some View {
        HStack {
            Text(blockName)
            Image(systemName: "chevron.right")
            .imageScale(.small)
            Spacer()
        }
            .tint(.black)
            .font(.title3)
            .fontWeight(.light)
            .padding(.leading, 20)
    }
    
    @ViewBuilder
    func allRecipesView() -> some View {
        NavigationLink (destination: {
            Assembler.sharedAssembly
                .resolver
                .resolve(AllRecipesView.self)
        }, label: {
            titleButtonOfBlock(blockName: "recipes.allrecipes.button".localized)
                .padding(.top, 8)
        })
            if (viewModel.allRecipes.isEmpty) {
                Text("recipes.allrecipes.error.message".localized)
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 12) {
                        ForEach (viewModel.allRecipes, id: \.self) { recipie in
                            RecipeCardView(recipe: recipie)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .contentMargins(.horizontal, 12)
            }
    }
    
    @ViewBuilder
    func cookToTimeView() -> some View {
        VStack {
            HStack {
                Text("recipes.cooktotime.label".localized)
                    .tint(.black)
                    .font(.title3)
                    .fontWeight(.light)
                    .padding(.leading, 20)
                    .padding(.top, 8)
                Spacer()
            }
            GeometryReader {proxy in
                HStack(spacing: (proxy.size.width - 320 - 12)/5) {
                    CardToTimeView(viewModel: viewModel, type: .breakfast, proxy: proxy)
                    CardToTimeView(viewModel: viewModel, type: .lunch, proxy: proxy)
                    CardToTimeView(viewModel: viewModel, type: .dinner, proxy: proxy)
                    CardToTimeView(viewModel: viewModel, type: .snacks, proxy: proxy)
                }
                .tint(.black)
                .padding(.horizontal, (proxy.size.width - 320 + 12)/5)
            }
            .frame(height: 96)
            
        }
    }
    
    @ViewBuilder
    func recentRecipesView() -> some View {
        NavigationLink (destination: {
            Assembler.sharedAssembly
                .resolver
                .resolve(RecentRecipesView.self)
        }, label: {titleButtonOfBlock(blockName: "recipes.recents.button".localized)})
        .padding(.top, 8)
        if (viewModel.recentRecipes.isEmpty) {
            VStack(spacing: 10) {
                Text("recipes.recents.zero.message".localized)
                Text("recipes.recents.zero.info".localized)
                    .font(.caption2)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 220, height: 100)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(.rect(cornerRadius: 8))
        } else {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach (viewModel.recentRecipes, id: \.self) { recipe in
                        RecipeCardView(recipe: recipe)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, 12)
        }
    }
    
    @ViewBuilder
    func myRecipesView() -> some View {
        NavigationLink (destination: {
            Assembler.sharedAssembly
                .resolver
                .resolve(MyRecipesView.self)
        }, label: {
            titleButtonOfBlock(blockName: "recipes.myrecipes.button".localized)
        })
            .padding(.top, 8)
        if (viewModel.myRecipes.isEmpty) {
            VStack(spacing: 10) {
                Text("recipes.myrecipes.zero.message".localized)
                Text("recipes.myrecipes.zero.info".localized)
                    .font(.caption2)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 220, height: 100)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(.rect(cornerRadius: 8))
            .padding(.bottom, 12)
        } else {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach (viewModel.myRecipes, id: \.self) { recipe in
                        RecipeCardView(recipe: recipe)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, 12)
            .padding(.bottom, 12)
        }
    }
}

