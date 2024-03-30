//
//  LiveRecipesView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var appViewBuilder: ApplicationViewBuilder

    var body: some View {
        TabView {
            ForEach(Tabs.allCases) { tab in
                appViewBuilder.build(view: tab)
                    .tabItem { Label(tab.tabName, systemImage: tab.tabIcon)
                    }
            }
        }
        .tint(.orange)
    }
}

#Preview {
    RootView(appViewBuilder: ApplicationViewBuilder())
}
