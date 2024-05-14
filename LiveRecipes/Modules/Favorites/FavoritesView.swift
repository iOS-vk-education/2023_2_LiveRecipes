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
                    .onChange(of: selectedSegment) {
                        print("Selected segment: \(segments[selectedSegment])")
                    }
                    
                if selectedSegment == 0 {
                    Spacer()
                    recipesView()
                    Spacer()
                }
                else {
                    Spacer()
                    myRecipesView()
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
        if (!viewState.allRecipes.isEmpty) {
            GeometryReader {proxy in
                ScrollView() {
                    LazyVStack(spacing: 12) {
                        ForEach(viewState.allRecipes, id: \.self) { recipe in
                            RecipeBigCardView(recipe: recipe, proxy: proxy)
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
    func myRecipesView() -> some View {
        if (viewState.myRecipes.isEmpty) {
            VStack() {
                Image(systemName: "archivebox")
                    .resizable()
                    .frame(width: 180, height: 155)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor.systemGray3))
                    .padding(.bottom, 0)
                Text("favorites.myRecipes.isEmpty".localized)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor.systemGray3))
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 4)
                NavigationLink {
                    Assembler.sharedAssembly
                        .resolver
                        .resolve(CreationView.self)
                } label: {
                    Text("myrecipes.tocreation".localized)
                        .fontWeight(.semibold)
                    Image(systemName: "plus.app")
                }
            }
            .padding(.bottom, 30)
        } else {
            GeometryReader {proxy in
                ScrollView() {
                    LazyVStack(spacing: 12) {
                        ForEach(viewState.myRecipes, id: \.self) { recipe in
                            withAnimation(.easeInOut) {
                                RecipeBigCardView(recipe: recipe, proxy: proxy)
                            }
                        }
                    }
                    
                    Button(action: {
                        
                    }) {
                        NavigationLink(destination:{
                            Assembler.sharedAssembly
                                .resolver
                            .resolve(CreationView.self)}) {
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
}


//import SwiftUI
//
//struct FavoritesView: View {
//    @StateObject var viewState: FavoritesViewModel
//
//    var body: some View {
//        Text(Tabs.favorites.tabName)
//    }
//}
//
//#Preview {
//    ApplicationViewBuilder.stub.build(view: .favorites)
//}
