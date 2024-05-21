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

    var body: some View {
        List {
            Section {
                    Picker(selection: $viewState.selectedSegment, label: Text("Select a segment")) {
                        ForEach(0..<viewState.segments.count) { index in
                            Text(viewState.segments[index]).tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 350)
                    .listRowBackground(Color.clear)
                    .onChange(of: viewState.selectedSegment) { _, _ in
                        viewState.changeTheme()
                    }
                    .preferredColorScheme(viewState.colorScheme)
            } header: {
                Text("theme.settings".localized)
            }
            Section(header: Text("settings.userSettings".localized)) {
                Button(action: {
                    viewState.clearMyRecipes()
                })
                {
                    Text("settings.clearMyRecipes".localized)
                        .tint(Color(uiColor: .label))
                }
                
                Button(action: {
                    viewState.clearFavorites()
                })
                {
                    Text("settings.clearFavourites".localized)
                        .tint(Color(uiColor: .label))
                }
                Button(action: {
                    viewState.clearRecents()
                })
                {
                    Text("settings.clearRecents".localized)
                        .tint(Color(uiColor: .label))
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
