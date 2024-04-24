//
//  IngredientRunningTextView.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 24.04.2024.
//

import SwiftUI

struct IngredientRunningTextView: View {
    @State private var textOffset: CGSize
    var duration: Double
    var text: String
    var finishWidth: Int
    
    init(duration: Double, text: String, offsetWidth: Int, finishWidth: Int) {
        self.textOffset = CGSize(width: offsetWidth, height: 0)
        self.duration = duration
        self.text = text
        self.finishWidth = finishWidth
    }
    
    func getWidth(for text: String) -> CGFloat {
            let size = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
            return size.width
        }
    
    var body: some View {
        VStack {
            Spacer()
            Text(text)
                .frame(width: getWidth(for: text) + 50, height: 50)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.black)
                .offset(textOffset)
            Spacer()
        }
        .onAppear {
            withAnimation(.bouncy(duration: duration)) {
                textOffset = CGSize(width: finishWidth, height: 0)
            }
        }
    }
}
