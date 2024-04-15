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
    @State private var searchText = ""
    @State private var isSearching = ""
    @State var modalKeyWordsIsOpen: Bool = false
    @State var modalFiltersIsOpen: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    keyWordsView()
                    allRecipesView()
                    cookToTimeView()
                    recentRecipesView()
                    myRecipesView()
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle(Tabs.recipes.tabName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack (spacing: 4) {
                        Button("", systemImage: "gear") {
                            print("hello")
                        }
                        Button("", systemImage: "slider.horizontal.2.square") {
                            modalFiltersIsOpen = true
                        }
                        .sheet(isPresented: $modalFiltersIsOpen) {
                            Assembler.sharedAssembly
                                .resolver
                                .resolve(FiltersView.self)
                           }
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .refreshable(action: {
                        print("refresh")
                    })
    }
    
    @ViewBuilder
    func keyWordsView() -> some View {
        if (viewModel.keyWords.isEmpty) {
            Text("Ошибка загрузки данных")
        } else {
            Button  {
                modalKeyWordsIsOpen = true
            } label: {
                titleButtonOfBlock(blockName: "Найти по ключевым словам")
            }.sheet(isPresented: $modalKeyWordsIsOpen) {
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
                            Text("Больше слов")
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
            titleButtonOfBlock(blockName: "Рецепты")
                .padding(.top, 8)
        })
            if (viewModel.allRecipes.isEmpty) {
                Text("Ошибка загрузки данных")
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 12) {
                        ForEach (viewModel.allRecipes) { recipie in
                            VStack (spacing: 0) {
                                Image(recipie.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 220, height: 100)
                                    .clipped()
                                VStack (spacing: 2) {
                                    HStack (spacing: 3) {
                                        Text(recipie.name)
                                            .fontWeight(.medium)
                                            .font(.system(size: 9))
                                        Spacer()
                                        Image(systemName: "clock")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 7, height: 7)
                                            .tint(.secondary)
                                        Text(recipie.time + " мин")
                                            .font(.system(size: 8))
                                    }
                                    .padding(.horizontal, 8)
                                    HStack {
                                        Text(recipie.cathegory)
                                            .fontWeight(.light)
                                            .foregroundStyle(Color(uiColor: .darkGray))
                                            .font(.system(size: 8))
                                        Spacer()
                                        Text(recipie.isInFavorites ? "В избранном" : "Добавить в избранное")
                                            .foregroundStyle(recipie.isInFavorites ? Color.yellow : Color.blue)
                                            .font(.system(size: 8))
                                            .fontWeight(.light)
                                    }
                                    .padding(.horizontal, 8)
                                }
                                .frame(width: 220, height: 35)
                            }
                            .frame(width: 220, height: 135)
                            .background(Color(UIColor.secondarySystemBackground))
                            .clipShape(.rect(cornerRadius: 8))
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
                Text("Приготовьте ко времени")
                    .tint(.black)
                    .font(.title3)
                    .fontWeight(.light)
                    .padding(.leading, 20)
                    .padding(.top, 8)
                Spacer()
            }
            GeometryReader {proxy in
                HStack(spacing: (proxy.size.width - 320 - 12)/5) {
                    VStack {
                        Image("caesar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(.rect(cornerRadius: 8))
                            .clipped()
                        Text("Завтрак")
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                    VStack {
                        Image("caesar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(.rect(cornerRadius: 8))
                            .clipped()
                        Text("Обед")
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                    VStack {
                        Image("caesar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(.rect(cornerRadius: 8))
                            .clipped()
                        Text("Ужин")
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                    VStack {
                        Image("caesar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(.rect(cornerRadius: 8))
                            .clipped()
                        Text("Перекус")
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                }
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
        }, label: {titleButtonOfBlock(blockName: "Недавние")})
        .padding(.top, 8)
        if (viewModel.recentRecipes.isEmpty) {
            VStack(spacing: 10) {
                Text("Здесь пока пусто")
                Text("Тут будут отображаться ранее просмотренные рецепты")
                    .font(.caption2)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 220, height: 100)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(.rect(cornerRadius: 8))
        } else {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach (viewModel.recentRecipes) { recipe in
                        VStack (spacing: 0) {
                            Image(recipe.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 220, height: 100)
                                .clipped()
                            VStack (spacing: 2) {
                                HStack (spacing: 3) {
                                    Text(recipe.name)
                                        .fontWeight(.medium)
                                        .font(.system(size: 9))
                                    Spacer()
                                    Image(systemName: "clock")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 7, height: 7)
                                        .tint(.secondary)
                                    Text(recipe.time + " мин")
                                        .font(.system(size: 8))
                                }
                                .padding(.horizontal, 8)
                                HStack {
                                    Text(recipe.cathegory)
                                        .fontWeight(.light)
                                        .foregroundStyle(Color(uiColor: .darkGray))
                                        .font(.system(size: 8))
                                    Spacer()
                                    Text(recipe.isInFavorites ? "В избранном" : "Добавить в избранное")
                                        .foregroundStyle(recipe.isInFavorites ? Color.yellow : Color.blue)
                                        .font(.system(size: 8))
                                        .fontWeight(.light)
                                }
                                .padding(.horizontal, 8)
                            }
                            .frame(width: 220, height: 35)
                        }
                        .frame(width: 220, height: 135)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(.rect(cornerRadius: 8))
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
            titleButtonOfBlock(blockName: "Мои рецепты")
        })
            .padding(.top, 8)
        if (viewModel.myRecipes.isEmpty) {
            VStack(spacing: 10) {
                Text("Здесь пока пусто")
                Text("Тут будут отображаться созданные Вами рецепты")
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
                    ForEach (viewModel.myRecipes) { recipe in
                        VStack (spacing: 0) {
                            Image(recipe.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 220, height: 100)
                                .clipped()
                            VStack (spacing: 2) {
                                HStack (spacing: 3) {
                                    Text(recipe.name)
                                        .fontWeight(.medium)
                                        .font(.system(size: 9))
                                    Spacer()
                                    Image(systemName: "clock")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 7, height: 7)
                                        .tint(.secondary)
                                    Text(recipe.time + " мин")
                                        .font(.system(size: 8))
                                }
                                .padding(.horizontal, 8)
                                HStack {
                                    Text(recipe.cathegory)
                                        .fontWeight(.light)
                                        .foregroundStyle(Color(uiColor: .darkGray))
                                        .font(.system(size: 8))
                                    Spacer()
                                    Text(recipe.isInFavorites ? "В избранном" : "Добавить в избранное")
                                        .foregroundStyle(recipe.isInFavorites ? Color.yellow : Color.blue)
                                        .font(.system(size: 8))
                                        .fontWeight(.light)
                                }
                                .padding(.horizontal, 8)
                            }
                            .frame(width: 220, height: 35)
                        }
                        .frame(width: 220, height: 135)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(.rect(cornerRadius: 8))
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, 12)
            .padding(.bottom, 12)
        }
    }
}

