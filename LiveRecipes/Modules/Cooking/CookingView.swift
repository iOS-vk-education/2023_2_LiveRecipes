//
//  CookingView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import SwiftUI

struct CookingView: View {
    @StateObject var viewState: CookingViewModel

    var body: some View {
        Text(Tabs.cooking.tabName)
    }
}

#Preview {
    ApplicationViewBuilder.stub.build(view: .cooking)
}
