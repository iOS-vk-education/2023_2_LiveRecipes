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
    @StateObject var creationViewModel = CreationViewModel(creationModel: CreationModel())//это временная дичь

    var body: some View {
            List {
                Section(header: Text("settings.userSettings".localized)) {
                    Button(action: {
                        viewState.clearMyRecipes()
                    })
                    {
                        Text("settings.clearMyRecipes".localized)
                            .tint(.black)
                    }
                    
                    Button(action: {
                        viewState.clearFavorites()
                    })
                    {
                        Text("settings.clearFavourites".localized)
                            .tint(.black)
                    }
                    Button(action: {
                        viewState.clearRecents()
                    })
                    {
                        Text("settings.clearRecents".localized)
                            .tint(.black)
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
        .navigationTitle("settings".localized)
        .navigationBarTitleDisplayMode(.inline)
    }
}
