//
//  OneStepView.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 12.04.2024.
//

import SwiftUI
import Swinject

struct OneStepView: View {
    @StateObject var viewModel: CookingViewModel
    @State var disconnectText = false
    var stepNumber: Int
    
    var body: some View {
            ScrollView {
                HStack() {
                    Text("Цезарь с креветками")
                        .font(.system(size: 20, weight: .medium))
                    Spacer()
                }
                .padding()
                
                VStack {
                    VStack {
                        Image(viewModel.steps[stepNumber - 1]["image"] ?? "")
                            .resizable()
                            .frame(width: 370, height: 260)
                        Text(viewModel.steps[stepNumber - 1]["description"] ?? "")
                            .padding(.bottom)
                    }.background(Color(UIColor.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    TimerView(totalTime: 10, timeForProgress: 10, disconnectText: $disconnectText)
                    
                    if stepNumber + 1 <= viewModel.steps.count {
                        Button(action: {
                            print("nextStep")
                        }) {
                            
                            NavigationLink(destination: OneStepView(viewModel: viewModel,stepNumber: stepNumber + 1)) {
                                HStack {
                                    Spacer()
                                    Text("Следующий шаг")
                                        .foregroundStyle(.white)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.white)
                                }.frame(width: 330, height: 35)
                                
                            }
                            
                        }.buttonStyle(.borderedProminent)
                            .tint(.orange)
                        
                    }
                    else {
                        Button(action: {
                            
                        }) {
                            NavigationLink(destination:{
                                Assembler.sharedAssembly
                                    .resolver
                                .resolve(RecipesView.self)}) {
                                    HStack {
                                        Spacer()
                                        Text("На главную")
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                        
                                        Image(systemName: "fork.knife")
                                            .foregroundStyle(.white)
                                        Spacer()
                                    }.frame(width: 330, height: 35)
                                }
                                
                        }
                        .buttonStyle(.borderedProminent)
                            .tint(.black)
                    }
                }
            }
            .gesture(TapGesture().onEnded({
                disconnectText = true
        }))
            .navigationTitle(stepNumber == viewModel.steps.count ? "Последний шаг" :"Шаг \(stepNumber)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(stepNumber == 1 ? true : false)
        .toolbar(.visible, for: .tabBar)
        
    }
}

