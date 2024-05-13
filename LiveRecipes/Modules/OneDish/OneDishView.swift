//
//  OneDishView.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 30.03.2024.
//

import SwiftUI
import Swinject


struct OneDishView: View {
    @StateObject var viewState: OneDishViewModel
    @State private var isScrollDown = true
    
    @State var crs: CGFloat = 0
    @State var minYwritten = false
    @State var globalMinY: CGFloat = 0
    
    var openedFromRecipesView: Bool = true
    
    var body: some View {
        if viewState.foundRecipe.ingredients.isEmpty {
            ProgressView()
        }
        else {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack {
                        VStack {
                            if let data = Data(base64Encoded: viewState.foundRecipe.photo), let image = UIImage(data: data) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width - 20, height: 280)
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            }
                            else {
                                Image("caesar")
                                    .resizable()
                                    .frame(width: 370, height: 260)
                                
                            }
                                Text(viewState.foundRecipe.name)
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 5)
                            
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundStyle(.orange)
                                HStack(spacing: 0){
                                    Text("oneDish.timeToCook".localized)
                                    if viewState.foundRecipe.decomposeDuration().0 != 0 {
                                        Text(" \(viewState.foundRecipe.decomposeDuration().0)")
                                        Text(" дн ")
                                        Text("\(viewState.foundRecipe.decomposeDuration().1)")
                                        Text(" ч ")
                                        Text("\(viewState.foundRecipe.decomposeDuration().2)")
                                        Text(" мин ")
                                    }
                                    else {
                                        Text(" \(viewState.foundRecipe.decomposeDuration().1)")
                                        Text(" ч ")
                                        Text("\(viewState.foundRecipe.decomposeDuration().2)")
                                        Text(" мин ")
                                    }
                                }
                                Spacer()
                            }
                            .padding(.leading, 8)
                            HStack {
                                Image(systemName: "fork.knife.circle")
                                    .foregroundStyle(.orange)
                                Text("oneDish.nutritionalValue".localized)
                                
                                Spacer()
                            }.padding(.leading, 8)
                            Divider()
                            
                            HStack {
                                VStack {
                                    Text("oneDish.calories".localized)
                                        .foregroundStyle(Color(.systemGray))
                                        .padding(.top, 5)
                                    HStack(spacing: 0) {
                                        Text("\(viewState.foundRecipe.bzy.calories)")
                                        Text("oneDish.kcal".localized)
                                    }
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.systemGray))
                                    .multilineTextAlignment(.center)
                                }.padding(.trailing, 10)
                                Divider().frame(height: 60)
                                VStack {
                                    Text("oneDish.proteins".localized)
                                        .foregroundStyle(Color(.systemGray))
                                        .padding(.top, 5)
                                    HStack(spacing: 0) {
                                        Text("\(viewState.foundRecipe.bzy.protein)")
                                        Text("г".localized)
                                        
                                    }
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.systemGray))
                                    .multilineTextAlignment(.center)
                                }
                                Divider().frame(height: 60)
                                VStack {
                                    Text("oneDish.fats".localized)
                                        .foregroundStyle(Color(.systemGray))
                                        .padding(.top, 5)
                                    HStack(spacing: 0) {
                                        Text(viewState.foundRecipe.bzy.fats)
                                        Text("г".localized)
                                    }.font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(.systemGray))
                                }
                                Divider().frame(height: 60)
                                VStack {
                                    Text("oneDish.carbohydrates".localized)
                                        .padding(.top, 5)
                                        .foregroundStyle(Color(.systemGray))
                                    HStack(spacing: 0) {
                                        Text(viewState.foundRecipe.bzy.carbohydrates)
                                        Text("г".localized)
                                    }.font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(.systemGray))
                                }
                            }
                            
                            Divider()
                            
                            
                            Text("oneDish.nutritionalValue100gr".localized)
                                .font(.system(size: 13))
                                .padding(.bottom, 20)
                                .foregroundStyle(Color(.systemGray))
                            
                            HStack {
                                Image(systemName: "carrot")
                                    .foregroundStyle(.orange)
                                Text("oneDish.compostion".localized)
                                Spacer()
                                Text("oneDish.dishNumber".localized)
                                    .fontWeight(.light)
                                    .padding(.trailing, 8)
                                
                            }.padding(.leading, 8)
                                .padding(.bottom, 10)
                            ForEach(Array(viewState.foundRecipe.ingredients.enumerated()), id: \.offset) { index, ingredient in
                                HStack {
                                    Image(systemName: "smallcircle.filled.circle")
                                        .foregroundStyle(.black)
                                    Text(ingredient)
                                    Spacer()
                                    
                                }.padding(.leading, 10)
                                    .padding(.bottom, 8)
                            }
                        }.background(Color(UIColor.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .frame(width: UIScreen.main.bounds.width - 20)
                        
                        HStack {
                            Text("oneDish.description".localized)
                                .font(.system(size: 24, weight: .regular))
                            Spacer()
                        }
                        .padding(.init(top: 16, leading: 0, bottom: 1, trailing: 0))
                        .frame(width: UIScreen.main.bounds.width - 20)
                        //.padding(.init(top: 0, leading: 18, bottom: 5, trailing: 0))
                        HStack {
                            Text(viewState.foundRecipe.description)
                                .lineSpacing(8)
                            
                        }.frame(width: UIScreen.main.bounds.width - 20)
                            //.padding(.top, 1)
                        //.padding(.init(top: 0, leading: 18, bottom: 10, trailing: 10))
                    }
                    .padding()
                    
                    GeometryReader{reader in
                        Color.clear
                            .onChange(of: reader.frame(in: .named("newSpace"))) {
                                if !minYwritten {
                                    globalMinY = reader.frame(in: .named("newSpace")).minY
                                    minYwritten = true
                                }
                                
                                let currentMinY = reader.frame(in: .named("newSpace")).minY
                                
                                if crs <= currentMinY && abs(currentMinY - crs) > 50 {
                                    if !isScrollDown {
                                        withAnimation(.easeInOut) {
                                            isScrollDown.toggle()
                                        }
                                    }
                                    if currentMinY < globalMinY {
                                        crs = reader.frame(in: .named("newSpace")).minY
                                    }
                                    
                                }
                                if crs > currentMinY && abs(currentMinY - crs) > 50 {
                                    if isScrollDown {
                                        withAnimation(.easeInOut) {
                                            isScrollDown.toggle()
                                        }
                                    }
                                    if currentMinY < globalMinY {
                                        crs = reader.frame(in: .named("newSpace")).minY
                                    }
                                }
                                
                            }
                    }
                }.navigationTitle(viewState.foundRecipe.name)
                
                Button(action: {
                    
                }) {
                    NavigationLink(destination:{
                        PrepareForCookingView(recipe: viewState.foundRecipe)
                    }) {
                        HStack {
                            Spacer()
                            Image(systemName: "stove.fill")
                                .imageScale(.large)
                                .foregroundColor(.white)
                            Text("oneDish.toCooking".localized)
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.white)
                            Spacer()
                        }.frame(width: 200, height: 35)
                    }
                }.buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .opacity(isScrollDown ? 1.0 : 0.0)
                    .padding()
            }

//                Button(action: {
//                    
//                }) {
//                    NavigationLink(destination:{
//                        Assembler.sharedAssembly
//                            .resolver
//                        .resolve(CookingView.self)}) {
//                            Image(systemName: "oven.fill")
//                                .foregroundColor(.white)
//                            Text("К приготовлению")
//                                .frame(width: 150, height: 35)
//                                .foregroundStyle(.white)
//                            Image(systemName: "arrow.right")
//                                .foregroundStyle(.white)
//                        }
//                }.buttonStyle(.borderedProminent)
//                    .tint(.orange)
//                    .opacity(isScrollDown ? 1.0 : 0.0)
//                    .padding()
            }
        }
    }

