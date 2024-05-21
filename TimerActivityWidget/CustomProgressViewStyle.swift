//
//  CustomProgressViewStyle.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 12.05.2024.
//

import SwiftUI

struct CustomTimerViewStyle: ProgressViewStyle {
    var progress: Int
    
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(UIColor.white).opacity(1))
                    .frame(width: geometry.size.width, height: 12)
                    .overlay(alignment: .leading){
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.orange)
                            .frame(width: configuration.fractionCompleted.map { $0 * (geometry.size.width)}, height: configuration.fractionCompleted! < 0.025 ? 6 : 12)
                            .animation(.linear, value: progress)
                    }
            }
        }
    }
}
