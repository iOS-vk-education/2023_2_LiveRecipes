//
//  BlinkingText + TimerView.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 24.04.2024.
//

import SwiftUI
import ActivityKit
import Foundation
import UserNotifications

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
    @State private var currentActivity: Activity<TimerAttributes>?
   
    @State var isTimerRunning = false
    @State private var progress: Int = 0
    @State private var isPaused = false
    
    @State var totalTime: Int
    
    @State var timeForProgress: Int
    @State var activityStarted: Bool = false
    
    var step: String?
    var stepsCount: Int?
    var dishName: String?
    var timerSeted: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var minutesAndSeconds: (Int,Int, Int) {
        let hours = timeForProgress / 3600
        let minutes = timeForProgress / 60
        let seconds = timeForProgress % 60
        
        return (hours, minutes, seconds)
    }
    
    func notify() -> Void {
        let content = UNMutableNotificationContent()
        content.title = "LiveRecipes"
        if let step = step {
            content.body = step + "timer.step.completed".localized
        }
        else {
            content.body = "timer.over".localized
        }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
    
    func stopActivity() {
        Task {
            await currentActivity?.end(nil, dismissalPolicy: .immediate)
            activityStarted = false
        }
    }
    
    func updateActivity() {
        Task {
            let state = TimerAttributes.TimeState(progress: progress, totalTime: totalTime, timeRemaining: timeForProgress, currentStep: step ?? "", stepsCount: stepsCount ?? 0, interval: nil)
            //await currentActivity?.update(using: state)
            await currentActivity?.update(ActivityContent<TimerAttributes.TimeState>(state: state, staleDate: nil))
            //await currentActivity?.update(using: state)
        }
    }
    
    func startActivity() {
        activityStarted = true
        let startTime = TimeInterval(totalTime)
        let endTime = TimeInterval(0)
        let interval = ClosedRange(uncheckedBounds: (lower: Date().addingTimeInterval(endTime), upper: Date().addingTimeInterval(startTime)))
        
        let attributes = TimerAttributes(dishName: dishName ?? "")
        let state = TimerAttributes.TimeState(progress: 0, totalTime: totalTime, timeRemaining: timeForProgress, currentStep: step ?? "", stepsCount: stepsCount ?? 0, interval: interval)
        let content = ActivityContent(state: state, staleDate: nil, relevanceScore: 0.0)
        
        do {
            currentActivity = try Activity<TimerAttributes>.request(attributes: attributes, content: content)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        let (hours, minutes, seconds) = minutesAndSeconds
        
        VStack {
            HStack {
                Button(action: {
                    isTimerRunning = false
                    progress = 0
                    timeForProgress = totalTime
                    stopActivity()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .imageScale(.large)
                }
                
                Spacer()
                
                Button(action: {
                    if timeForProgress >= 120 {
                        if totalTime > 120 {
                            totalTime -= 120
                        }
                        else {
                            totalTime -= 119
                        }
                        timeForProgress = totalTime
                    }
                    }) {
                    Text("- 2 мин")
                        .foregroundStyle(.red)
                }.opacity(activityStarted || timerSeted ? 0.0 : 1.0)
                
                Spacer()
                
                Text("timer".localized)
                    
                Image(systemName: "timer")
                
                Spacer()
                
                Button(action: {
                    if totalTime == 1 {
                        totalTime += 119
                    }
                    else {
                        totalTime += 120
                    }
                    timeForProgress = totalTime
                }) {
                    Text("+ 2 мин")
                        .foregroundStyle(.green)
                        
                }.opacity(activityStarted || timerSeted ? 0.0 : 1.0)
                
                Spacer()
                
                Button(action: {
                    isTimerRunning.toggle()
                    if activityStarted {
                       // updateActivity()
                    }
                    else {
                        startActivity()
                        //progress = timeForProgress
                    }
                }) {
                    Image(systemName: isTimerRunning ? "pause.fill" : "play.fill")
                        .imageScale(.large)
                }.disabled(timeForProgress == 0 || totalTime == 1 ? true : false)
                
            }.padding(.init(top: 8, leading: 8, bottom: 0, trailing: 8))
            
            ZStack {
                ProgressView(value: Double(timeForProgress), total: Double(totalTime))
                    .progressViewStyle(CustomProgressViewStyle(progress: $progress))
                if timeForProgress < 0 {
                    Text("Готово!")
                        .foregroundColor(.orange)
                        .font(.system(size: 19, weight: .semibold))
                        .padding(.top, 2)
                }
                else {
                    if totalTime == 1 {
                        Text("0m:0s")
                            .foregroundColor(.black)
                            .font(.system(size: 19, weight: .semibold))
                            .padding(.top, 2)
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
                                        //updateActivity()
                                    }
                                    
                                    if progress == totalTime {
                                        isTimerRunning = false
                                        //updateActivity()
                                        stopActivity()
                                        notify()
                                    }
                                }
                            }
                    }
                }
            }
            .padding(.init(top: 0, leading: 8, bottom: 16, trailing: 8))
        }.background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .frame(width: UIScreen.main.bounds.width - 20)
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
                            .frame(width: configuration.fractionCompleted.map { $0 * geometry.size.width }, height: configuration.fractionCompleted ?? 0 < 0.025 ? 15 : 30)
                            .animation(.linear, value: progress)
                    }
            }
        }
    }
}
