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
    let texts = ["Креветки 4шт", "Салат 8 листов", "Сухарики 9 грамм", "Креветки 4 шт", "Соль по вкусу", "Перец по вкусу",
                 "Креветки 4шт", "Салат 8 листов", "Сухарики 9 грамм", "Креветки 4 шт", "Соль по вкусу", "Перец по вкусу"]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Не забудьте перед готовкой")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.orange)
                Spacer()
                ZStack(alignment: .bottom) {
                    ScrollView {
                        ForEach(0..<texts.count) {index in
                            let _ = print(geometry.size)
                            if index % 2 == 0 {
                                IngredientRunningTextView(duration: Double(index + 1), text: texts[index], offsetWidth: -450, finishWidth: 80)
                                    .frame(width: geometry.size.width)
                            }
                            else {
                                IngredientRunningTextView(duration: Double(index + 1), text: texts[index], offsetWidth: 450, finishWidth: -80)
                            }
                        }
                        
                    }.frame(minWidth: geometry.size.width, minHeight: geometry.size.height * 0.7)
                        .scrollIndicators(.hidden)
                    TransperentBlur()
                        .blur(radius: 10)
                        .frame(height: 70)
                        .padding(.bottom, -40)
                    
                }
                
                DurationTextWithBlur(text: "20-30 минут")
                StartCookingButton()
                
            }.background(RadialGradient(gradient: Gradient(colors: [.orange, .white]), center: .center, startRadius: 50, endRadius: 400)
                .ignoresSafeArea()
                .toolbar(.hidden, for: .tabBar)
                .navigationBarBackButtonHidden(true)
            )
        }
    }
}
