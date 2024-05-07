//
//  BlinkingText + TimerView.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 24.04.2024.
//

import SwiftUI

struct BlinkingText: View {
    @State private var isVisible = true
    let text: String
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    @Binding var disconnectTimer: Bool
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.system(size: 19, weight: .semibold))
            .padding(.top, 2)
            .onReceive(timer) { _ in
                isVisible.toggle()
            }
            .opacity(isVisible || disconnectTimer ? 1 : 0)
            .gesture(TapGesture().onEnded({
                timer.upstream.connect().cancel()
        }))
        if disconnectTimer {
            let _ = timer.upstream.connect().cancel()
        }
    }
}

struct TimerView: View {
    @State var isTimerRunning = false
    @State private var progress: Int = 0
    @State private var isPaused = false
    
    var totalTime: Int
    @State var timeForProgress: Int
    @Binding var disconnectText: Bool
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var minutesAndSeconds: (Int,Int, Int) {
        let hours = timeForProgress / 3600
        let minutes = timeForProgress / 60
        let seconds = timeForProgress % 60
        
        return (hours, minutes, seconds)
    }

    var body: some View {
        let (hours, minutes, seconds) = minutesAndSeconds
        
        VStack {
            HStack {
                Button(action: {
                    isTimerRunning = false
                    progress = 0
                    timeForProgress = totalTime
                    disconnectText = false
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .imageScale(.large)
                }
                
                Spacer()
                
                Text("Таймер")
                Image(systemName: "timer")
                
                Spacer()
                
                Button(action: {
                    isTimerRunning.toggle()
                    
                }) {
                    Image(systemName: isTimerRunning ? "pause.fill" : "play.fill")
                        .imageScale(.large)
                }.disabled(timeForProgress == 0 ? true : false)
                
            }.padding(.init(top: 8, leading: 8, bottom: 0, trailing: 8))
            
            ZStack {
                ProgressView(value: Double(progress), total: Double(totalTime))
                    .progressViewStyle(CustomProgressViewStyle(progress: $progress))
                if timeForProgress == 0 {
                    BlinkingText(text: "Готово", disconnectTimer: $disconnectText)
                }
                else {
                    Text(hours == 0 ? "\(minutes)m:\(seconds)s" : "\(hours)h:\(minutes)m:\(seconds)s")
                        .foregroundColor(.black)
                        .font(.system(size: 19, weight: .semibold))
                        .padding(.top, 2)
                    
                        .onReceive(timer) { _ in
                            if isTimerRunning {
                                if progress < totalTime {
                                    progress += 1
                                    timeForProgress -= 1
                                    
                                }
                                if progress == totalTime {
                                    disconnectText = false
                                    isTimerRunning = false
                                }
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
