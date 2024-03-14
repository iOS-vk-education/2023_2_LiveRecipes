//
//  CookingView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/13/24.
//

import SwiftUI

struct CookingView: View {
    @ObservedObject var cookingViewModel: CookingViewModel
    @EnvironmentObject var cookingModel: CookingModel
    var body: some View {
        ZStack {
            Button(action: { print("button") }) { Text("Buttton") }
        }
    }
}

#Preview {
    CookingView(cookingViewModel: CookingViewModel(cookingModel: CookingModel()))
}
