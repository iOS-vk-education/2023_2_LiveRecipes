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
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
                ScrollView {
                    VStack {
                        VStack {
                            Image("caesar")
                                .resizable()
                                .frame(width: 370, height: 260)
                            Text("Цезарь с креветками")
                                .font(.system(size: 22))
                                .fontWeight(.medium)
                                .padding(.bottom, 5)
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundStyle(.orange)
                                Text("Время приготовления 20 - 30 мин")
                                Spacer()
                            }
                            .padding(.leading, 8)
                            HStack {
                                Image(systemName: "fork.knife.circle")
                                    .foregroundStyle(.orange)
                                Text("Пищевая ценность:")
                                
                                Spacer()
                            }.padding(.leading, 8)
                            Divider()
                            
                            HStack {
                                VStack {
                                    Text("Калории")
                                        .foregroundStyle(Color(.systemGray))
                                        .padding(.top, 5)
                                        
                                    Text("132кКал")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(.systemGray))
                                }.padding(.trailing, 10)
                                Divider().frame(height: 60)
                                VStack {
                                    Text("Белки")
                                        .foregroundStyle(Color(.systemGray))
                                        .padding(.top, 5)
                                    Text("12г")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(.systemGray))
                                }
                                Divider().frame(height: 60)
                                VStack {
                                    Text("Жиры")
                                        .foregroundStyle(Color(.systemGray))
                                        .padding(.top, 5)
                                    Text("12г")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(.systemGray))
                                }
                                Divider().frame(height: 60)
                                VStack {
                                    Text("Углеводы")
                                        .padding(.top, 5)
                                        .foregroundStyle(Color(.systemGray))
                                    Text("15г")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(.systemGray))
                                }
                            }
                            
                            Divider()
                            
                            
                            Text("Пищевая ценность на 100г")
                                .font(.system(size: 13))
                                .padding(.bottom, 20)
                                .foregroundStyle(Color(.systemGray))
                            
                            HStack {
                                Image(systemName: "carrot")
                                    .foregroundStyle(.orange)
                                Text("Состав:")
                                Spacer()
                                Text("Кол-во порций: 5")
                                    .fontWeight(.light)
                                    .padding(.trailing, 8)
                                
                            }.padding(.leading, 8)
                            HStack {
                                Image(systemName: "smallcircle.filled.circle")
                                Text("Креветки 4шт")
                                Spacer()
                            }.padding(.leading, 10)
                            HStack {
                                Image(systemName: "smallcircle.filled.circle")
                                Text("Салат 8 листов")
                                Spacer()
                            }.padding(.leading, 10)
                            HStack {
                                Image(systemName: "smallcircle.filled.circle")
                                Text("Сухарики 9 грамм")
                                Spacer()
                            }.padding(.leading, 10)
                            HStack {
                                Image(systemName: "smallcircle.filled.circle")
                                Text("Соль по вкусу")
                                Spacer()
                            }.padding(.leading, 10)
                            HStack {
                                Image(systemName: "smallcircle.filled.circle")
                                Text("Перец по вкусу")
                                Spacer()
                                Text("Добавить продукты\n в список покупок")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.orange)
                                Image(systemName: "cart")
                                    .foregroundStyle(.orange)
                                
                                
                            }.padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                        }.background(Color(UIColor.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .padding()
                        
                        HStack {
                            Text("Описание:")
                                .font(.title3)
                            Spacer()
                        }
                        .padding(.init(top: 0, leading: 18, bottom: 5, trailing: 0))
                        HStack {
                            Text("Соус для салата «Цезарь» был придуман почти 100 лет назад в Америке. Когда посетители ресторана съели все приготовленные блюда и требовали еще, хозяину ничего другого не оставалось, как собрать все оставшиеся продукты в один салат и добавить к нему тот самый соус. Классический соус для салата «Цезарь» довольно-таки непрост в приготовлении. Вариаций приготовления много. Например, в нашем рецепте салата «Цезарь» с курицей в основе заправки — вустерширский соус, яичные желтки и горчица.")
                                .lineSpacing(4)
                            //Text("oneDish.caesar.description")
                            
                        }.padding(.init(top: 0, leading: 12, bottom: 10, trailing: 10))
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
                }.navigationTitle("Цезарь")
            
            Button(action: {
                
            }) {
                NavigationLink(destination:{
                    PrepareForCookingView()
                    }) {
                        Image(systemName: "stove.fill")
                            .foregroundColor(.white)
                        Text("К приготовлению")
                            .frame(width: 150, height: 35)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                    }
            }.buttonStyle(.borderedProminent)
                .tint(.orange)
                .opacity(isScrollDown ? 1.0 : 0.0)
                .padding()

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

