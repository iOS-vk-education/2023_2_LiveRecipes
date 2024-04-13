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
    
    var stepNumber: Int
    
    var body: some View {
        let _ = print(viewModel.steps)
            ScrollView {
                HStack() {
                    Text("Цезарь с креветками")
                        .font(.system(size: 20, weight: .medium))
                    Spacer()
                }
                .padding()
                
                VStack {
                    Image(viewModel.steps[stepNumber - 1]["image"] ?? "")
                        .resizable()
                        .frame(width: 370, height: 260)
                    Text(viewModel.steps[stepNumber - 1]["description"] ?? "")
                        .padding(.bottom)
                    
                    TimerView()
                    
                        Button(action: {
                            print("nextStep")
                        }) {
                            
                            NavigationLink(destination: OneStepView(viewModel: viewModel,stepNumber: stepNumber + 1)) {
                                Text("Следующий шаг")
                                    .frame(width: 300, height: 35)
                                    .foregroundStyle(.white)
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.white)
                                
                            }
                            
                        }.buttonStyle(.borderedProminent)
                            .tint(.orange)
                            .disabled(stepNumber + 1 <= viewModel.steps.count ? false : true)
                    
                }
            }
        .navigationTitle("Шаг \(stepNumber)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TimerView: View {
    @State var isTimerRunning = false
    @State private var progress: Int = 0
    let totalTime: Int = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var minutesAndSeconds: (Int,Int, Int) {
        let hours = progress / 3600
        let minutes = progress / 60
        let seconds = progress % 60
        return (hours, minutes, seconds)
        
    }

    
    var body: some View {
        let (hours, minutes, seconds) = minutesAndSeconds
        VStack {
            HStack {
                Text("Таймер")
                Image(systemName: "timer")
                
                Spacer()
                
                Button("Запустить") {
                    isTimerRunning = true
                    progress = 0
                }
            }.padding(.init(top: 8, leading: 8, bottom: 0, trailing: 8))
            
            ZStack {
                ProgressView(value: Double(progress), total: Double(totalTime))
                    .progressViewStyle(CustomProgressViewStyle(progress: $progress))
                
                Text(hours == 0 ? "\(minutes)m:\(seconds)s" : "\(hours)h:\(minutes)m:\(seconds)s")
               
                    .foregroundColor(.black)
                    .font(.system(size: 19, weight: .semibold))
                    .padding(.top, 2)
                
                
                    .onReceive(timer) { _ in
                        if isTimerRunning {
                            if progress < totalTime {
                                progress += 1
                            } else {
                                isTimerRunning = false
                            }
                        }
                        
                    }
            }
            .padding(.init(top: 0, leading: 8, bottom: 16, trailing: 8))
        }.background(Color(UIColor.systemGray6))
            .cornerRadius(10)
        .padding()
    }
}


struct CustomProgressViewStyle: ProgressViewStyle {
    @Binding var progress: Int
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 15)
                    
                    .foregroundColor(Color(UIColor.white).opacity(1))
                    .frame(width: geometry.size.width, height: 30)
                    .overlay(alignment: .leading){
                        
                        
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.orange)
                            .frame(width: configuration.fractionCompleted.map { $0 * geometry.size.width }, height: 30)
                            .animation(.linear, value: progress)
                    }
                
                

            }
        }
    }
}
