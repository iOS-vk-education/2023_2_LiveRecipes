//
//  OneStepView.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 12.04.2024.
//

import SwiftUI
import Swinject
import ActivityKit


struct OneStepView: View {
    @EnvironmentObject var model: OneStepViewModel

    var body: some View {
        if model.steps.count > 0 {
             
                ZStack(alignment: .center) {
                    ScrollView {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(model.dishName)
                                    .font(.system(size: 20, weight: .medium))
                                Text(getTranslation(model.dishType))
                                    .font(.system(size: 16, weight: .light))
                            }
                            Spacer()
                        }
                        .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 10))
                        
                        VStack {
                            VStack {
                                if let data = Data(base64Encoded: model.steps[model.stepNumber - 1][1]), let image = UIImage(data: data) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width - 20, height: 260)
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                }
                                Text(model.steps[model.stepNumber - 1][0])
                                    .lineSpacing(8)
                                    .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
                            }.background(Color(UIColor.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .padding()
                            
                            if model.steps[model.stepNumber - 1][2] != "0" {
                                
                                TimerView(totalTime: Int(model.steps[model.stepNumber - 1][2]) ?? 0, timeForProgress: Int(model.steps[model.stepNumber - 1][2]) ?? 0, step: "oneStep.step\(model.stepNumber)".localized, stepsCount: model.steps.count, dishName: model.dishName, timerSeted: true)
                                    .onAppear {
                                        model.isTimerOnView = true
                                        model.objectWillChange.send()
                                    }
                                
                            }
                            else {
                                TimerView(totalTime: 1, timeForProgress: 1, step: "oneStep.step\(model.stepNumber)".localized, stepsCount: model .steps.count, dishName: model.dishName)
                                    .offset(y: model.isLanded ? 0 : -1000)
                                    .contextMenu(menuItems: {
                                        Button("Delete", systemImage: "trash") {
                                            withAnimation(.spring()) {
                                                model.isLanded = false
                                                model.isTimerOnView = false
                                                model.objectWillChange.send()
                                            }
                                        }
                                    })
                            }
                            if model.stepNumber + 1 <= model.steps.count {
                                Button(action: {
                                    withAnimation {
                                        model.stepNumber = model.stepNumber + 1
                                        model.objectWillChange.send()
                                        model.updatePublished()
                                    }
                                }) {
                                        HStack {
                                            Spacer()
                                            Text("oneStep.nextStep".localized)
                                                .foregroundStyle(.white)
                                                .fontWeight(.semibold)
                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(.white)
                                                .frame(height: 35)
                                            Spacer()
                                        }
                                    
                                }.buttonStyle(.borderedProminent)
                                    .tint(.orange)
                                    .padding(.init(top: 0, leading: 0, bottom: 40, trailing: 0))
                                    .frame(width: UIScreen.main.bounds.width - 20)
                                    .offset(y: model.isTimerOnView ? 10 : -100)
//                                Button(action: {
//
//                                }) {
//                                    NavigationLink(destination: {}) {
//                                        HStack {
//                                            Spacer()
//                                            Text("oneStep.nextStep".localized)
//                                                .foregroundStyle(.white)
//                                                .fontWeight(.semibold)
//                                            Image(systemName: "chevron.right")
//                                                .foregroundStyle(.white)
//                                                .frame(height: 35)
//                                            Spacer()
//                                        }
//
//                                    }
//                                    .simultaneousGesture(TapGesture().onEnded {
//                                        print(model.stepNumber)
//                                        model.stepNumber = model.stepNumber + 1
//                                        model.objectWillChange.send()
//                                        print(model.stepNumber)
//                                    })
//                                }.buttonStyle(.borderedProminent)
//                                    .tint(.orange)
//                                    .padding(.init(top: 0, leading: 0, bottom: 40, trailing: 0))
//                                    .frame(width: UIScreen.main.bounds.width - 20)
//                                    .offset(y: model.isTimerOnView ? 10 : -100)
                                
                            }
                            else {
                                Button(action: {
                                    model.steps = []
                                    model.objectWillChange.send()
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("oneStep.toMainPage".localized)
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                        
                                        Image(systemName: "fork.knife")
                                            .foregroundStyle(.white)
                                            .frame(height: 35)
                                        Spacer()
                                    }
                                }.buttonStyle(.borderedProminent)
                                    .tint(.black)
                                    .padding(.bottom, 20)
                                    .frame(width: UIScreen.main.bounds.width - 20)
                                    .offset(y: model.isTimerOnView ? 10 : -100)
                            }
                        }
                    }
                    .blur(radius: model.blurIsActive ? 20 : 0)
                    .onAppear {
                        if model.stepNumber > 1 {
                            model.updatePublished()
                        }
                        if model.stepNumber == 1 && model.firstAppearence {
                            model.blurIsActive = true
                        }
                        model.firstAppearence = false
                    }
                    if model.blurIsActive {
                        Image("Image".localized)
                    }
                }
                .onTapGesture {
                    model.blurIsActive = false
                }
                .navigationTitle(model.stepNumber == model.steps.count ? "oneStep.lastStep".localized :"oneStep.step\(model.stepNumber)".localized)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(model.stepNumber == 1 ? true : false)
                .toolbar(.visible, for: .tabBar)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button (action: {
                            withAnimation(.spring()) {
                                model.isLanded = true
                                model.isTimerOnView = true
                                model.objectWillChange.send()
                            }
                        }) {
                            Image(systemName: "timer")
                                .imageScale(.large)
                                .foregroundStyle(.orange)
                        }.opacity(model.isTimerOnView ? 0.0 : 1.0)
                            .simultaneousGesture(TapGesture().onEnded {
//                                model.isLanded = true
//                                model.isTimerOnView = true
//                                model.objectWillChange.send()
                                print(model.isLanded)
                            })
                    }
                    if model.stepNumber > 1 {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                withAnimation {
                                    model.updatePublished()
                                    model.stepNumber = model.stepNumber - 1
                                    model.objectWillChange.send()
                                }
                            }) {
                                Image(systemName: "arrow.left")
                                    .imageScale(.large)
                                    .foregroundStyle(.orange)
                            }
                        }
                    }
                }
                    
            }
       
    }
}
