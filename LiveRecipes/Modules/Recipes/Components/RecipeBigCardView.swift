//
//  RecipeBigCardView.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 16.04.2024.
//

import SwiftUI

struct RecipeBigCardView: View {
    @State var recipe: Recipe
    var proxy: GeometryProxy
    
    var body: some View {
        NavigationLink(destination: {
            OneDishView(viewState: OneDishViewModel(oneDishModel: OneDishModel()))
        }, label: {
            ZStack(alignment: .topTrailing) {
                VStack (spacing: 0) {
                    Image(recipe.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.size.width - 24, height: 170)
                        .clipped()
                    VStack {
                        HStack {
                            Text(recipe.name)
                                .fontWeight(.medium)
                                .font(.system(size: 15))
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        HStack {
                            Text(recipe.cathegory)
                                .fontWeight(.light)
                                .foregroundStyle(Color(uiColor: .darkGray))
                                .font(.system(size: 14))
                            Spacer()
                            Image(systemName: "clock")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 13, height: 13)
                            Text(recipe.time + "recipes.card.time".localized)
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal, 8)

                    }
                    .frame(width: proxy.size.width - 24, height: 60)
                }
                .frame(width: proxy.size.width - 24, height: 230)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(.rect(cornerRadius: 8))
                .tint(.black)
                VStack {
                    Image(systemName: recipe.isInFavorites ? "star.fill" : "star")
                        .resizable()
                        .foregroundStyle(Color.yellow)
                        .fontWeight(.medium)
                        .gesture(TapGesture().onEnded({ _ in
                            recipe.changeStateOfFavorites()
                        }))
                        .scaledToFit()
                }
                .frame(width: 25, height: 25)
                .padding(4)
            }
        })
    }
}
