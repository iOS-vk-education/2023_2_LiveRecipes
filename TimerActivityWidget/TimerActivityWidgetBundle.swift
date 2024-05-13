//
//  TimerActivityWidgetBundle.swift
//  TimerActivityWidget
//
//  Created by Сергей Мирошниченко on 11.05.2024.
//

import WidgetKit
import SwiftUI

@main
struct TimerActivityWidgetBundle: WidgetBundle {
    var body: some Widget {
        TimerActivityWidget()
        TimerActivityWidgetLiveActivity()
    }
}
