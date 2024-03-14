//
//  FavoritesView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewState: FavoritesViewModel

    var body: some View {
        Text(Tabs.favorites.tabName)
    }
}

#Preview {
    ApplicationViewBuilder.stub.build(view: .favorites)
}
