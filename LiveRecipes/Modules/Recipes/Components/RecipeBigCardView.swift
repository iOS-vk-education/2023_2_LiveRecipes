//
//  RecipeBigCardView.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 16.04.2024.
//

import SwiftUI

struct RecipeBigCardView: View {
    @State var viewModel: RecipesViewModel
    @State var recipe: RecipePreviewDTO
    var loadRecipeFromCD = false
    
    var body: some View {
        NavigationLink(destination: {
            OneDishView(viewState: OneDishViewModel(oneDishModel: OneDishModel(), id: recipe.id, loadRecipeFromCD: loadRecipeFromCD))
        }, label: {
            ZStack(alignment: .topTrailing) {
                VStack (spacing: 0) {
                    if let data = Data(base64Encoded: recipe.photo), let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 24, height: 170)
                            .clipped()
                    }
                    VStack {
                        HStack {
                            Text(recipe.name)
                                .fontWeight(.medium)
                                .font(.system(size: 15))
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        HStack {
                            Text(getTranslation(recipe.tag))
                                .fontWeight(.light)
                                .foregroundStyle(Color(uiColor: .darkGray))
                                .font(.system(size: 14))
                            Spacer()
                            Image(systemName: "clock")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 13, height: 13)
                            Text(recipe.decomposeDuration())
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal, 8)

                    }
                    .frame(width: UIScreen.main.bounds.width - 24, height: 60)
                }
                .frame(width: UIScreen.main.bounds.width - 24, height: 230)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(.rect(cornerRadius: 8))
                .tint(.black)
                VStack {
                    Image(systemName: recipe.isInFavorites ?? false ? "star.fill" : "star")
                        .resizable()
                        .foregroundStyle(Color.orange)
                        .fontWeight(.medium)
                        .gesture(TapGesture().onEnded({ _ in
                            if (recipe.isInFavorites ?? viewModel.isSaved(recipe: recipe)) {
                                viewModel.deleteIdFromFavorites(recipe: recipe)
                                viewModel.deleteFromCoreDataFavorites(recipe: recipe)
                            } else {
                                viewModel.saveIdToFavorites(recipe: recipe)
                                viewModel.saveToCoreDataFavorites(recipe: recipe)
                            }
                            recipe.changeStateOfFavorites()
                        }))
                        .scaledToFit()
                }
                .frame(width: 25, height: 25)
                .padding(4)
            }
        })
        .onAppear {
            recipe.setFavorites()
        }
    }
}
