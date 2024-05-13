//
//  LiveActivityAttributes.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 11.05.2024.
//

import Foundation
import ActivityKit
import SwiftUI

public struct TimerAttributes: ActivityAttributes {
    public typealias TimeState = ContentState
    
    public struct ContentState: Codable, Hashable {
        var progress: Int
        var totalTime: Int
        var timeRemaining: Int
        var currentStep: String
        var stepsCount: Int
        var interval: ClosedRange<Date>?
    }
    
    var dishName: String
}
