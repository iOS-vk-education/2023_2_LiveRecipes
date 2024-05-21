//
//  LiveRecipesView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import SwiftUI
import Swinject

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
    
    @StateObject private var tabSelectionManager: TabSelectionManager = Assembler.sharedAssembly.resolver.resolve(TabSelectionManager.self) ?? TabSelectionManager()

    @StateObject private var cookingRecipe: OneStepViewModel = OneStepViewModel(model: OneStepModel(stepNumber: 0, steps: [], dishName: "", dishType: ""))

    var body: some View {
        TabView(selection: $tabSelectionManager.selection) {
            ForEach(Tabs.allCases) { tab in
                appViewBuilder.build(view: tab, tabBinding: $tabSelectionManager.selection)
                    .tabItem { Label(tab.tabName, systemImage: tab.tabIcon) }
            }.toolbarBackground(.visible, for: .tabBar)
        }.tint(.orange)
            .environmentObject(tabSelectionManager)
                    .environmentObject(cookingRecipe)
    }
}

//#Preview {
//    RootView(appViewBuilder: ApplicationViewBuilder())
//}
