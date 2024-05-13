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
                    Text("settings.clearFavourites".localized)
                        .onTapGesture {
                            print("settings.clearFavourites".localized)
                        }
                    Text("settings.clearMyRecipes".localized)
                        .onTapGesture {
                            print("settings.clearMyRecipes".localized)
                            RecipeDataManager.shared.deleteAll {
                                print("everything is deleted")
                            }
                        }
                    Text("settings.clearList".localized)
                        .onTapGesture {
                            print("settings.clearList".localized)
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
        //.toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}
