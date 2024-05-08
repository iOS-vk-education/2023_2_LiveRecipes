//
//  OneStepView.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 12.04.2024.
//

import SwiftUI
import Swinject

struct OneStepView: View {
    //@StateObject var viewModel: CookingViewModel
    @State var disconnectText = false
    var stepNumber: Int
    var steps: [[String]]
    var dishName: String
    var dishType: String
    
    var body: some View {
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Text(dishName)
                            .font(.system(size: 20, weight: .medium))
                        Text(dishType)
                            .font(.system(size: 16, weight: .light))
                    }
                    Spacer()
                }
                .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 10))
            
                VStack {
                    VStack {
                        if let data = Data(base64Encoded: steps[stepNumber - 1][1]), let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 20, height: 260)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                        Text(steps[stepNumber - 1][0])
                            .lineSpacing(8)
                            .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
                    }.background(Color(UIColor.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding()
                    
                    if steps[stepNumber - 1][2] != "0" {
                        TimerView(totalTime: Int(steps[stepNumber - 1][2]) ?? 0, timeForProgress: Int(steps[stepNumber - 1][2]) ?? 0, disconnectText: $disconnectText)
                            .padding(.bottom, 10)
                    }
                    if stepNumber + 1 <= steps.count {
                        Button(action: {
                            
                        }) {
                            NavigationLink(destination: OneStepView(stepNumber: stepNumber + 1, steps: steps, dishName: dishName, dishType: dishType)) {
                                HStack {
                                    Spacer()
                                    Text("oneStep.nextStep")
                                        .foregroundStyle(.white)
                                        .fontWeight(.semibold)
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.white)
                                        .frame(height: 35)
                                    Spacer()
                                }
                                
                            }
                            
                        }.buttonStyle(.borderedProminent)
                            .tint(.orange)
                            .padding(.init(top: 0, leading: 0, bottom: 40, trailing: 0))
                            .frame(width: UIScreen.main.bounds.width - 20)
                        
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
                                        Text("oneStep.toMainPage")
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
                            .padding(.bottom, 20)
                    }
                }
            }
            .gesture(TapGesture().onEnded({
                disconnectText = true
        }))
            .navigationTitle(stepNumber == steps.count ? "oneStep.lastStep".localized :"oneStep.step\(stepNumber)".localized)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(stepNumber == 1 ? true : false)
        .toolbar(.visible, for: .tabBar)
        
    }
}

