//
//  RecipeCardView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/19/24.
//
//
//import SwiftUI
//
//struct RecipeCardView: View {
//    @Binding var recipeName: String
//    @Binding var recipeTime: String
//    @Binding var recipeType: String
//
//    var body: some View {
//        ZStack {
//            Color(red: 0.949, green: 0.949, blue: 0.969)
//            VStack {
//                Spacer().frame(width: 200, height: 100)
//                HStack {
//                    VStack(alignment: .leading, content:
//                    {
//                        Text(recipeName).font(.caption2)
//                        Spacer()
//                        Text(recipeType).font(.caption2)
//                    })
//                    VStack(alignment: .trailing, content:
//                    {
//                        Text(recipeTime).font(.caption2)
//                        Spacer()
//                        Text("Подробнее").font(.caption2)
//                    })
//                }
//            }
//        }.frame(width: 300, height: 135)
//    }
//}
//
////#Preview {
//    RecipeCardView(recipeName: Binding.constant("Салат цезарь с креветками"), recipeTime: Binding.constant("20-30 минут"), recipeType: Binding.constant("Салаты"))
//}


import SwiftUI

struct RecipeCardView: View {
    @State var recipe: Recipe
    
    var body: some View {
        NavigationLink(destination: {
            OneDishView(viewState: OneDishViewModel(oneDishModel: OneDishModel()))
        }, label: {
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
                            .gesture(TapGesture().onEnded({ _ in
                                recipe.changeStateOfFavorites()
                            }))
                    }
                    .padding(.horizontal, 8)
                }
                .frame(width: 220, height: 35)
            }
            .frame(width: 220, height: 135)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(.rect(cornerRadius: 8))
            .tint(.black)
        })
    }
}
