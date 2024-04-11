//
//  SettingsView.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 11.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewState: SettingsViewModel

    var body: some View {
        Text(Tabs.list.tabName)
    }
}

#Preview {
    ApplicationViewBuilder.stub.build(view: .list)
}
