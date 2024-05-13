//
//  PrepareForCookingView.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 23.04.2024.
//

import SwiftUI
import Swinject

struct PrepareForCookingView: View {
    @State private var animatedTextIndex = 0
    @State private var durationText = ""
    @Environment(\.presentationMode) var presentationMode
    
    let recipe: RecipeDTO

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                ZStack(alignment: .bottom) {
                    ScrollView {
                        ForEach(0..<recipe.ingredients.count, id: \.self) {index in
                            if index % 2 == 0 {
                                IngredientRunningTextView2(duration: Double(index + 2), text: recipe.ingredients[index], startX: 450)
                                    .frame(width: geometry.size.width)
                            }
                            else {
                                IngredientRunningTextView2(duration: Double(index + 2), text: recipe.ingredients[index], startX: -450)
                            }
                        }
                    }.frame(minWidth: geometry.size.width, minHeight: geometry.size.height * 0.7)
                        .scrollIndicators(.hidden)
                        .onAppear {
                            if recipe.decomposeDuration().0 != 0 {
                                durationText += " \(recipe.decomposeDuration().0)"
                                durationText += "cookingPrepare.days".localized
                                durationText += " \(recipe.decomposeDuration().1)"
                                durationText += "cookingPrepare.hours".localized
                                durationText += " \(recipe.decomposeDuration().2)"
                                durationText += "cookingPrepare.minutes".localized
                            }
                            else {
                                durationText += " \(recipe.decomposeDuration().1)"
                                durationText += "cookingPrepare.hours".localized
                                durationText += " \(recipe.decomposeDuration().2)"
                                durationText += "cookingPrepare.minutes".localized
                            }
                        }
                    TransperentBlur()
                        .blur(radius: 10)
                        .frame(height: 70)
                        .padding(.bottom, -40)
                    
                }
                
                
                DurationTextWithBlur(text: durationText)
                StartCookingButton(transferData: recipe)
                
            }.background(RadialGradient(gradient: Gradient(colors: [.orange, .white]), center: .center, startRadius: 50, endRadius: 400)
                .ignoresSafeArea()
                .toolbar(.hidden, for: .tabBar)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("", systemImage: "chevron.left") {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("cookingPrepare.dontForget".localized)
                            .foregroundStyle(.orange)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }
                .navigationBarBackButtonHidden(true)
            )
        }
    }
}
