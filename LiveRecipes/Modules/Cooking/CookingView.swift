//
//  CookingView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import SwiftUI
import Swinject

struct CookingView: View {
    @StateObject var viewModel: CookingViewModel
    @State var timeRemaining = 2
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        
        if viewModel.steps.count == 0 {
            let _ = viewModel.findSteps()
            NoSteps()
            
        }
        else {
            let _ = print(viewModel.steps.count)
            OneStepView(viewModel: viewModel, stepNumber: 1)
            //OneStepView(image: "step1", description: "Описание шага 1", stepNumber: 1)
        }
    }
}













struct GaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.blue
    var strokeWidth = 25.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        print(fractionCompleted)

        return ZStack {
            Rectangle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .square))
                //.rotationEffect(.degrees(-90))
        }
    }
}



struct NoSteps: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "oven")
                    .resizable()
                    .frame(width: 150, height: 130)
                    .foregroundColor(Color(UIColor.systemGray3))
                    .padding()
                Text("Выберете рецепт и начните готовить!")
                    .foregroundColor(Color(UIColor.systemGray3))
                    .fontWeight(.medium)
                
                NavigationLink(destination:{
                    Assembler.sharedAssembly
                        .resolver
                        .resolve(OneDishView.self)},
                               label: {
                    Text("К рецептам")
                        .font(.headline)
                        .foregroundStyle(Color(UIColor.orange))
                })
                
            }.navigationTitle("Готовка")
                .navigationBarTitleDisplayMode(.inline)
        }.tint(.orange)
    }
}


#Preview {
    ApplicationViewBuilder.stub.build(view: .cooking)
}
