//
//  SettingsView.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 11.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewState: SettingsViewModel
    @State private var isShowingCreationView = false
    @StateObject var creationViewModel = CreationViewModel(creationModel: CreationModel())
    @State var isClearMyRecipes = false
    @State var isClearFavorites = false
    @State var isClearRecents = false

    var body: some View {
        List {
            Section(header: Text("settings.userSettings".localized)) {
                Button(action: {
                    isClearMyRecipes = true
                })
                {
                    Text("settings.clearMyRecipes".localized)
                        .tint(Color(uiColor: .label))
                }.alert(isPresented: $isClearMyRecipes) {
                    Alert(title: Text("Очистить мои рецепты?"), primaryButton: .default(Text("Да")){
                        viewState.clearMyRecipes()
                        isClearMyRecipes = false
                    }, secondaryButton: .default(Text("Отмена")) {
                        isClearMyRecipes = false
                    })
                }
                
                Button(action: {
                    isClearFavorites = true
                    //viewState.clearMyRecipes()
                })
                {
                    Text("settings.clearFavourites".localized)
                        .tint(Color(uiColor: .label))
                }.alert(isPresented: $isClearFavorites) {
                    Alert(title: Text("Очистить избранное?"), primaryButton: .default(Text("Да")){
                        viewState.clearFavorites()
                        isClearFavorites = false
                    }, secondaryButton: .default(Text("Отмена")) {
                        isClearFavorites = false
                    })
                }
                    
                
//                Button(action: {
//                    viewState.clearFavorites()
//                })
//                {
//                    Text("settings.clearFavourites".localized)
//                        .tint(Color(uiColor: .label))
//                }
                Button(action: {
                    isClearRecents = true
                })
                {
                    Text("settings.clearRecents".localized)
                        .tint(Color(uiColor: .label))
                }.alert(isPresented: $isClearRecents) {
                    Alert(title: Text("Очистить недавние?"), primaryButton: .default(Text("Да")){
                        viewState.clearRecents()
                        isClearFavorites = false
                    }, secondaryButton: .default(Text("Отмена")) {
                        isClearFavorites = false
                    })
                }
                NavigationLink(destination: CreationView(viewState: creationViewModel), isActive: $isShowingCreationView, label: {
                    Text("settings.publishMyRecipe".localized)
                        .onTapGesture {
                            print("settings.publishMyRecipe".localized)
                            isShowingCreationView = true
                        }
                })
            }
        }
        .listSectionSpacing(.custom(10))
        .navigationTitle("settings".localized)
        .navigationBarTitleDisplayMode(.inline)
    }
}
