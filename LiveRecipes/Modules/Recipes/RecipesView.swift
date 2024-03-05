//
//  RecipesView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import SwiftUI

struct RecipesView: View {
    @StateObject var viewState: RecipesViewState

    var body: some View {
        Text("recipes.greeting")
    }
}

struct MainPreviews: PreviewProvider {
    static var previews: some View {
        ApplicationViewBuilder.stub.build(view: .main)
    }
}
