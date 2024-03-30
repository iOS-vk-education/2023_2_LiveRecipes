//
//  ListView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//
import SwiftUI

struct ListView: View {
    @StateObject var viewState: ListViewModel

    var body: some View {
        Text(Tabs.list.tabName)
    }
}

#Preview {
    ApplicationViewBuilder.stub.build(view: .list)
}
