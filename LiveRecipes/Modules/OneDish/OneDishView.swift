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
    
    var body: some View {
        
            ScrollView {
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
                    HStack {
                        Image(systemName: "fork.knife.circle")
                            .foregroundStyle(.orange)
                        Text("Пищевая ценность:")
                        
                        Spacer()
                    }
                    Divider()
                    
                    HStack {
                        VStack {
                            Text("Калории")
                            Text("132кКал")
                        }
                        Divider().frame(height: 60)
                        VStack {
                            Text("Белки")
                            Text("12г")
                        }
                        Divider().frame(height: 60)
                        VStack {
                            Text("Жиры")
                            Text("12г")
                        }
                        Divider().frame(height: 60)
                        VStack {
                            Text("Углеводы")
                            Text("15г")
                        }
                    }
                    
                    Divider()
                    
                    
                    Text("Пищевая ценность на 100г")
                        .font(.system(size: 13))
                        .padding(.bottom, 20)
                    
                    HStack {
                        Image(systemName: "carrot")
                            .foregroundStyle(.orange)
                        Text("Состав:")
                        Spacer()
                        Text("Кол-во порций: 5")
                            .fontWeight(.light)
                        
                    }
                    HStack {
                        Image(systemName: "smallcircle.filled.circle")
                        Text("Креветки 4шт")
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "smallcircle.filled.circle")
                        Text("Салат 8 листов")
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "smallcircle.filled.circle")
                        Text("Сухарики 9 грамм")
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "smallcircle.filled.circle")
                        Text("Соль по вкусу")
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "smallcircle.filled.circle")
                        Text("Перец по вкусу")
                        Spacer()
                        
                        Text("Добавить продукты\n в список покупок")
                            .font(.system(size: 12))
                            .foregroundStyle(.orange)
                        Image(systemName: "cart")
                            .foregroundStyle(.orange)
                        
                    }
                    .padding(.bottom, 20)
                    HStack {
                        Text("Описание:")
                        Spacer()
                    }
                    HStack {
                        
                        Text("Соус для салата «Цезарь» был придуман почти 100 лет назад в Америке. Когда посетители ресторана съели все приготовленные блюда и требовали еще, хозяину ничего другого не оставалось, как собрать все оставшиеся продукты в один салат и добавить к нему тот самый соус. Классический соус для салата «Цезарь» довольно-таки непрост в приготовлении. Вариаций приготовления много. Например, в нашем рецепте салата «Цезарь» с курицей в основе заправки — вустерширский соус, яичные желтки и горчица.")
                        //Text("oneDish.caesar.description")
                        
                        
                    }
                    
                    
                }
                .padding()
                
                Button(action: {
                    
                }) {
                    NavigationLink(destination:{
                        Assembler.sharedAssembly
                            .resolver
                        .resolve(CookingView.self)}) {
                            Image(systemName: "oven.fill")
                                .foregroundColor(.white)
                            Text("К приготовлению")
                                .frame(width: 150, height: 35)
                                .foregroundStyle(.white)
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.white)
                        }
                    
                    
                    
                }.buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .opacity(1)
                    .padding()
                
                    
                        
                    
                    
                

                
//                Button(action: {
//                    print("jsnjs")
//                }) {
//                    
//                    Image(systemName: "oven.fill")
//                        .foregroundColor(.white)
//                    Text("К приготовлению")
//                        .frame(width: 150, height: 35)
//                    Image(systemName: "arrow.right")
//                    
//                }.buttonStyle(.borderedProminent)
//                    .tint(.orange)
//                    .opacity(1)
//                Spacer()
                
                
            
        }.navigationTitle("Цезарь")
            
            
            
            
    }
}
