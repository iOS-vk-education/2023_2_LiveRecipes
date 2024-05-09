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
    @State var recipe: RecipeDTO
    
    var body: some View {
        NavigationLink(destination: {
            OneDishView(viewState: OneDishViewModel(oneDishModel: OneDishModel()))//??
        }, label: {
            ZStack (alignment: .topTrailing){
                VStack (spacing: 0) {
                    Image(uiImage: UIImage(data: Data(base64Encoded: recipe.photo)!)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 110)
                        .clipped()
                    VStack{
                        HStack {
                            Text(recipe.name)
                                .fontWeight(.medium)
                                .font(.system(size: 12))
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        HStack {
                            Text(recipe.tag)
                                .fontWeight(.light)
                                .foregroundStyle(Color(uiColor: .darkGray))
                                .font(.system(size: 11))
                            Spacer()
                            Image(systemName: "clock")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                            Text(recipe.duration)
                                .font(.system(size: 11))
                        }
                        .padding(.horizontal, 8)
                    }
                    .frame(width: 180, height: 50)
                }
                .frame(width: 180, height: 160)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(.rect(cornerRadius: 8))
                .tint(.black)
                VStack {
                    Image(systemName: recipe.isInFavorites ?? false ? "star.fill" : "star")
                        .resizable()
                        .foregroundStyle(Color.orange)
                        .fontWeight(.medium)
                        .gesture(TapGesture().onEnded({ _ in
                            recipe.changeStateOfFavorites()
                        }))
                        .scaledToFit()
                }
                .frame(width: 25, height: 25)
                .padding(3)
            }
        })
    }
}
