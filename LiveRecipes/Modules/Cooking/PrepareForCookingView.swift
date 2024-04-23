//
//  PrepareForCookingView.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 23.04.2024.
//

import SwiftUI
import Swinject

struct PrepareForCookingView: View {
    let texts = ["Креветки 4шт", "Салат 8 листов", "Сухарики 9 грамм", "Креветки 4 шт", "Соль по вкусу", "Перец по вкусу",
                 "Креветки 4шт", "Салат 8 листов", "Сухарики 9 грамм", "Креветки 4 шт", "Соль по вкусу", "Перец по вкусу"]
    
    
    @State private var animatedTextIndex = 0 // индекс текущего анимированного текста
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Не забудьте перед готовкой")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.orange)
                Spacer()
                ScrollView {
                    ForEach(0..<texts.count) {index in
                        let _ = print(geometry.size)
                        if index % 2 == 0 {
                            RunningTextView(dur: Double(index + 1), text: texts[index], offsetWidth: -450, finishWidth: 80)
                                .frame(width: geometry.size.width)
                        }
                        else {
                            RunningTextView(dur: Double(index + 1), text: texts[index], offsetWidth: 450, finishWidth: -80)
                        }
                    }
                    
                }.frame(minWidth: geometry.size.width, minHeight: geometry.size.height * 0.7)
                    .scrollIndicators(.hidden)
                
                AnimatedTextWithBlur(text: "1 час 5 минут")
                AnimatedButton()
                
            }.background(RadialGradient(gradient: Gradient(colors: [.orange, .white]), center: .center, startRadius: 50, endRadius: 400)
                .ignoresSafeArea()
                .toolbar(.hidden, for: .tabBar)
            )
        }
    }
}

struct AnimatedButton: View {
    @State private var buttonOffset = CGSize(width: 0, height: 300)
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                
            }) {
                NavigationLink(destination:{
                    Assembler.sharedAssembly
                        .resolver
                    .resolve(CookingView.self)}) {
                        Text("Поехали!")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .offset(buttonOffset)
                    }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 3.5)) {
                    buttonOffset = CGSize.zero
                }
            }
            Spacer()
        }
    }
}


struct AnimatedTextWithBlur: View {
    var text: String
    @State private var blurRadius: CGFloat = 5
    @State private var opacity: Double = 0
    var body: some View {
        
        Text("Понадобиться времени")
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

struct RunningTextView: View {
    @State private var textOffset: CGSize
    var dur: Double
    var text: String
    var finishWidth: Int
    
    init(dur: Double, text: String, offsetWidth: Int, finishWidth: Int) {
        self.textOffset = CGSize(width: offsetWidth, height: 0)
        self.dur = dur
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
            withAnimation(.bouncy(duration: dur)) {
                textOffset = CGSize(width: finishWidth, height: 0)
            }
        }
    }
}





