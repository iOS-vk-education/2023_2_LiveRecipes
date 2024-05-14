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
    
    var body: some View {
        
        if model.steps.count == 0 {
            NoStepsView(tabSelected: tabSelected)
        } else {
            NavigationView {
                OneStepView()
            }
            
            
        }
        
    }
}

//        else {
//            let _ = print(viewModel.steps.count)
//            OneStepView(viewModel: viewModel, stepNumber: 1)
//        }



#Preview {
    ApplicationViewBuilder.stub.build(view: .cooking, tabBinding: Binding.constant(Tabs.recipes))
}
