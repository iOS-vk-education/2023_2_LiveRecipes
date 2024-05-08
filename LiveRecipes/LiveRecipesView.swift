//
//  LiveRecipesView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import SwiftUI

//class TabSelection: ObservableObject {
//    @Published var selectedTab: Tabs = .recipes
//}
//
//
//struct RootView: View {
//    @StateObject private var tabSelection = TabSelection()
//    @ObservedObject var appViewBuilder: ApplicationViewBuilder
//    @State private var tabSelected = Tabs.recipes
//
//    var body: some View {
//        TabView(selection: $tabSelection.selectedTab) {
//            ForEach(Tabs.allCases) { tab in
//                appViewBuilder.build(view: tab, tabBinding: $tabSelection.selectedTab)
//                    .tabItem { Label(tab.tabName, systemImage: tab.tabIcon) }
//                    //.tag(tabSelected)
//            }.toolbarBackground(.visible, for: .tabBar)
//        }.tint(.orange)
//            .environmentObject(tabSelection)
//    }
//}

struct RootView: View {
    @ObservedObject var appViewBuilder: ApplicationViewBuilder
    @State private var tabSelected = Tabs.recipes

    var body: some View {
        TabView(selection: $tabSelected) {
            ForEach(Tabs.allCases) { tab in
                appViewBuilder.build(view: tab, tabBinding: $tabSelected)
                    .tabItem { Label(tab.tabName, systemImage: tab.tabIcon) }
            }.toolbarBackground(.visible, for: .tabBar)
        }.tint(.orange)
    }
}

//#Preview {
//    RootView(appViewBuilder: ApplicationViewBuilder())
//}
