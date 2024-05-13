//
//  StartCookingButton.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 24.04.2024.
//

import SwiftUI
import Swinject

struct StartCookingButton: View {
    @EnvironmentObject private var tabSelectionManager: TabSelectionManager
    @EnvironmentObject private var stepViewModel: OneStepViewModel
    @State private var buttonOffset = CGSize(width: 0, height: 300)
    var transferData: RecipeDTO
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: { print("acccc" )}, label: {
                Text("TEST")
            })
            Button(action: {

            }) {
                NavigationLink(destination:{
                    OneStepView()
                }) {
                    Text("cookingPrepare.Go".localized)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .offset(buttonOffset)
                }
                .simultaneousGesture(TapGesture().onEnded {
                      // Perform navigation (handled by NavigationLink)
                    print("!!!!")
                    stepViewModel.setRecipe(model: transferData)
                    print(tabSelectionManager.selection)
                    tabSelectionManager.changeSelection(to: .cooking)
//                    tabSelectionManager.objectWillChange.send()
//                    tabSelectionManager.selection.se
                    print(tabSelectionManager.selection)
                })
            }
            .onAppear {
                withAnimation(.easeOut(duration: 3.5)) {
                    buttonOffset = CGSize.zero
                }
            }
            Spacer()
        }
    }
}

//struct StartCookingButton: View {
//    @State private var buttonOffset = CGSize(width: 0, height: 300)
//    @State private var tabSelected = Tabs.recipes
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            Button(action: {
//                
//            }) {
//                NavigationLink(destination:{
//                    Assembler.sharedAssembly
//                        .resolver
//                    .resolve(CookingView.self, argument: $tabSelected)}) {
//                        Text("Поехали!")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.orange)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                            .offset(buttonOffset)
//                    }
//            }
//            .onAppear {
//                withAnimation(.easeOut(duration: 3.5)) {
//                    buttonOffset = CGSize.zero
//                }
//            }
//            Spacer()
//        }
//    }
//}
