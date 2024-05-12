//
//  TimerActivityWidgetLiveActivity.swift
//  TimerActivityWidget
//
//  Created by Сергей Мирошниченко on 11.05.2024.
//

import ActivityKit
import WidgetKit
import SwiftUI


struct TimerActivityWidgetLiveActivity: Widget {
    
    func getHours(_ seconds: Int) -> Int {
        return seconds / 3600
    }
    
    func getMinutes(_ seconds: Int) -> Int {
        return seconds / 60
    }
    
    func getSeconds(_ seconds: Int) -> Int {
        return seconds % 60
    }
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack {
                VStack(alignment: .leading) {
                    Text(context.attributes.dishName)
                        .font(.title2)
                        .foregroundStyle(.black)
                        .fontWeight(.medium)
                    HStack(spacing: 0) {
                        Text(context.state.currentStep)
                            .font(.title3)
                            .foregroundStyle(.orange)
                            .fontWeight(.medium)
                        Text("/\(context.state.stepsCount)")
                            .font(.title3)
                            .foregroundStyle(.orange)
                            .fontWeight(.medium)
                    }
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Image(systemName: "timer")
                    Spacer()
                    Text(getSeconds(context.state.timeRemaining) < 10 ?
                         "\(getMinutes(context.state.timeRemaining))m:0\(getSeconds(context.state.timeRemaining))s" :
                            "\(getMinutes(context.state.timeRemaining))m:\(getSeconds(context.state.timeRemaining))s" )
                    .foregroundStyle(.orange)
                    .font(.title3)
                    .fontWeight(.medium)
                    
                }
            }
            .padding()
            .activityBackgroundTint(Color.white)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    HStack(spacing: 0){
                        Text(context.state.currentStep)
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                        Text("/\(context.state.stepsCount)")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                    }
                    .id(context.state)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Text(getSeconds(context.state.timeRemaining) < 10 ?
                            "\(getMinutes(context.state.timeRemaining))m:0\(getSeconds(context.state.timeRemaining))s" :
                            "\(getMinutes(context.state.timeRemaining))m:\(getSeconds(context.state.timeRemaining))s" )
                        .font(.title2)
                        .foregroundStyle(.orange)
                        .fontWeight(.semibold)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                    Image(systemName: "oven.fill")
                            .foregroundStyle(.orange)
                        .padding(.leading)
            
                    ProgressView(value: Double(context.state.progress), total: Double(context.state.totalTime))
                        .progressViewStyle(CustomTimerViewStyle(progress: context.state.progress))
                        .padding(.top, 4)
                        
                    Image(systemName: "checkmark")
                        .foregroundStyle(.green)
                            .padding(.trailing)
                    }
                }
                
            } compactLeading: {
                Image(systemName: "oven.fill")
                    .foregroundStyle(.orange)
            } compactTrailing: {
                Text(getSeconds(context.state.timeRemaining) < 10 ? 
                        "\(getMinutes(context.state.timeRemaining)):0\(getSeconds(context.state.timeRemaining))" :
                        "\(getMinutes(context.state.timeRemaining)):\(getSeconds(context.state.timeRemaining))" )
                    .foregroundStyle(.orange)
            } minimal: {
                Image(systemName: "oven.fill")
                    .foregroundStyle(.orange)
            }
        }
    }
}

