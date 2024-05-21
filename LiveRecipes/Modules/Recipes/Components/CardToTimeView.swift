//
//  CardToTimeView.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 11.05.2024.
//

import SwiftUI
import Swinject

struct CardToTimeView: View {
    @StateObject var viewModel: RecipesViewModel
    
    let type: NameToTime
    let proxy: GeometryProxy
    
    var body: some View {
        
        NavigationLink  {
            Assembler.sharedAssembly
                .resolver
                .resolve(CookToTimeView.self)
        } label: {
            VStack {
                Image(type.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(.rect(cornerRadius: 8))
                    .clipped()
                Text(type.title)
                    .fontWeight(.bold)
                    .font(.caption)
            }
        }
        .simultaneousGesture(TapGesture().onEnded{
            viewModel.type = type
            viewModel.isLoading = true
        })
    }
}

