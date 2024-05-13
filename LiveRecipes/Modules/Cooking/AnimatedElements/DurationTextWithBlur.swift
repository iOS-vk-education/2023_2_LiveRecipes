//
//  DurationTextWithBlur.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 24.04.2024.
//

import SwiftUI

struct DurationTextWithBlur: View {
    var text: String
    @State private var blurRadius: CGFloat = 5
    @State private var opacity: Double = 0
    var body: some View {
        
        Text("cookingPrepare.timeNeeded".localized)
            .font(.title2)
            .foregroundColor(.black)
            .blur(radius: blurRadius)
            .opacity(opacity)
            .multilineTextAlignment(.center)
            .onAppear {
                let animator = UIViewPropertyAnimator(duration: 4.5, curve: .easeInOut) {
                    self.opacity = 1
                }
                animator.startAnimation()
                
                withAnimation(Animation.easeInOut(duration: 4.5)) {
                    self.blurRadius = 0
                }
            }
        
        Text(text)
            .font(.largeTitle)
            .foregroundColor(.orange)
            .blur(radius: blurRadius)
            .opacity(opacity)
            .multilineTextAlignment(.center)
            .onAppear {
                let animator = UIViewPropertyAnimator(duration: 4.5, curve: .easeInOut) {
                    self.opacity = 1
                }
                animator.startAnimation()
                
                withAnimation(Animation.easeInOut(duration: 4.5)) {
                    self.blurRadius = 0
                }
            }
    }
}
