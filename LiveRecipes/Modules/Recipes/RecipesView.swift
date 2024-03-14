//
//  RecipesView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import SwiftUI

struct RecipesView: View {
    @StateObject var viewState: RecipesViewModel

    var body: some View {
        Text(Tabs.recipes.tabName)
    }
}

#Preview {
    ApplicationViewBuilder.stub.build(view: .cooking)
}
