//
//  RecipeCardView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/19/24.
//

import SwiftUI

struct RecipeCardView: View {
    @Binding var recipeName: String
    @Binding var recipeTime: String
    @Binding var recipeType: String

    var body: some View {
        ZStack {
            Color(red: 0.949, green: 0.949, blue: 0.969)
            VStack {
                Spacer().frame(width: 200, height: 100)
                HStack {
                    VStack(alignment: .leading, content:
                    {
                        Text(recipeName).font(.caption2)
                        Spacer()
                        Text(recipeType).font(.caption2)
                    })
                    VStack(alignment: .trailing, content:
                    {
                        Text(recipeTime).font(.caption2)
                        Spacer()
                        Text("Подробнее").font(.caption2)
                    })
                }
            }
        }.frame(width: 300, height: 135)
    }
}

#Preview {
    RecipeCardView(recipeName: Binding.constant("Салат цезарь с креветками"), recipeTime: Binding.constant("20-30 минут"), recipeType: Binding.constant("Салаты"))
}
