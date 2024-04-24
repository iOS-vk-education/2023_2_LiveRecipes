//
//  NoStepsView.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 24.04.2024.
//

import SwiftUI

struct NoStepsView: View {
    @Binding var tabSelected: Tabs

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "oven")
                    .resizable()
                    .frame(width: 150, height: 130)
                    .foregroundColor(Color(UIColor.systemGray3))
                    .padding()
                        
                Text("Выберете рецепт и начните готовить!")
                    .foregroundColor(Color(UIColor.systemGray3))
                    .fontWeight(.medium)
                
                Text("К рецептам")
                    .font(.headline)
                    .foregroundStyle(.orange)
                    .gesture(TapGesture().onEnded({
                        withAnimation(.linear(duration: 2)) {
                            tabSelected = Tabs.recipes
                        }
                }))

            }.navigationTitle("Готовка")
                .navigationBarTitleDisplayMode(.inline)
        }.tint(.orange)
    }
}
