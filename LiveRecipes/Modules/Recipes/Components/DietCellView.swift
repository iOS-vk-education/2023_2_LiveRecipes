//
//  DietCellView.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 20.04.2024.
//

import SwiftUI

struct DietCellView: View {
    @State var didSelected: Bool = false
    @State var didAnimate: Bool = false
    
    var body: some View {
        HStack {
            Text("filters.diet.name".localized)
            Spacer()
            Image(systemName: "checkmark")
                .imageScale(.medium)
                .foregroundStyle(.orange)
                .opacity(didSelected ? 1 : 0)
                .animation(.bouncy, value: didSelected)
        }
        .gesture(
            TapGesture()
                .onEnded({ _ in
                    didSelected.toggle()
                })
        )
    }
}
