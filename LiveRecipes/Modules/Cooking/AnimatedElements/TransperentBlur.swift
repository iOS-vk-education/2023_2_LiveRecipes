//
//  TransperentBlur.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 24.04.2024.
//

import SwiftUI

struct TransperentBlur: UIViewRepresentable {
    var removeFilter = false
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
    
}
