//
//  FiltersView.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 10.04.2024.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: RecipesViewModel
    @State private var ccal: Float = 900
    @State private var time: Float = 120
    @State private var contains = ""
    @State private var notContains = ""

    
    var body: some View {
        NavigationView {
            filtersView()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        VStack {
                            Image(systemName: "xmark")
                                .imageScale(.small)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(red: 0.2353, green: 0.2353, blue: 0.2627, opacity: 0.6))
                        }
                        .frame(width: 30, height: 30)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(.circle)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Применить") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Фильтры")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .background(Color(uiColor: .secondarySystemBackground))
        }
    }
    
    @ViewBuilder
    func filtersView() -> some View {
        List {
            Section {
                HStack {
                    Slider(value: $ccal, in: 0...3000, step: 1)
                    Text("\(ccal, specifier: "%g")кКал")
                        .frame(width: 90)
                }
                .listRowBackground(Color.clear)
            } header: {
                Text("Каллорийность")
            }
            Section {
                HStack {
                    Slider(value: $time, in: 0...240, step: 5)
                    Text("\(time, specifier: "%g") мин")
                        .frame(width: 90)
                }
                .listRowBackground(Color.clear)
            } header: {
                Text("Время приготовления")
            }
            Section {
                TextField("Введите ингридиент", text: $contains)
                    .overlay(
                        Button(action: {
                            contains = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .opacity(contains.isEmpty ? 0 : 1)
                                .imageScale(.medium)
                        },
                        alignment: .trailing
                    )
            } header: {
                Text("Содержит")
            }
            Section {
                TextField("Введите ингридиент", text: $notContains)
                    .overlay(
                        Button(action: {
                            notContains = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .opacity(notContains.isEmpty ? 0 : 1)
                                .imageScale(.medium)
                        },
                        alignment: .trailing
                    )
            } header: {
                Text("Не содержит")
            }
            Section {
                DietCellView()
                DietCellView()
                DietCellView()
                DietCellView()
                DietCellView()
            } header: {
                Text("Подобрать диету")
            }
        }
        .listSectionSpacing(8)
    }
}
