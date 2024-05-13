//
//  CookingView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import SwiftUI
import Swinject

struct CookingView: View {
    var tabSelected: Binding<Tabs>
    @EnvironmentObject var model: OneStepViewModel
    @StateObject var viewModel: CookingViewModel
    @State var timeRemaining = 2
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        if model.steps.count == 0 {
            NoStepsView(tabSelected: tabSelected)
        } else {
//            Text(model.dishName)
            OneStepView()
        }
    }
//        else {
//            let _ = print(viewModel.steps.count)
//            OneStepView(viewModel: viewModel, stepNumber: 1)
//        }
}


#Preview {
    ApplicationViewBuilder.stub.build(view: .cooking, tabBinding: Binding.constant(Tabs.recipes))
}
