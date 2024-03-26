//
//  CreationView.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 26.03.2024.
//

import SwiftUI

struct CreationView: View {
    @StateObject var viewState: CreationViewModel

    var body: some View {
        Text(Tabs.list.tabName)
    }
}

#Preview {
    ApplicationViewBuilder.stub.build(view: .list)
}
