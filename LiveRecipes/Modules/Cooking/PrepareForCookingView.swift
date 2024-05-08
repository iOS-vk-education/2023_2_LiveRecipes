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
    @Environment(\.presentationMode) var presentationMode
    //let texts = ["Креветки 4шт", "Салат 8 листов", "Сухарики 9 грамм", "Креветки 4 шт", "Соль по вкусу", "Перец по вкусу",
      //           "Креветки 4шт", "Салат 8 листов", "Сухарики 9 грамм", "Креветки 4 шт", "Соль по вкусу", "Перец по вкусу"]
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
                    TransperentBlur()
                        .blur(radius: 10)
                        .frame(height: 70)
                        .padding(.bottom, -40)
                    
                }
                
                DurationTextWithBlur(text: recipe.duration)
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
