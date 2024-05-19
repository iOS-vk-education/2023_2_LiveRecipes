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
                    Button {
                        viewModel.duration = ""
                        viewModel.calories = ""
                        viewModel.contains = []
                        viewModel.notContains = []
                        viewModel.findRecipesByFilter()
                    } label: {
                        VStack {
                            Text("filters.dismiss".localized)
                        }
                    }
                }
            }
            .navigationTitle("filters".localized)
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
                    Text("Каллорий")
                    Spacer()
                    Text(viewModel.isMoreCalories ? "больше" : "меньше")
                        .padding(.vertical, 6)
                        .padding(.horizontal, 8)
                        .frame(width: 80)
                        .foregroundStyle(.orange)
                        .background(.orange.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 10))
                        .multilineTextAlignment(.center)
                        .gesture(TapGesture().onEnded({ _ in
                            viewModel.isMoreCalories.toggle()
                        }))
                    Text("чем")
                    TextField("число", text: $viewModel.calories)
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                        .keyboardType(.numberPad)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.background))
                        .multilineTextAlignment(.center)
                        .frame(width: 90)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                HStack {
                    Text("Белков")
                    Spacer()
                    Text(viewModel.isMoreProtein ? "больше" : "меньше")
                        .padding(.vertical, 6)
                        .padding(.horizontal, 8)
                        .frame(width: 80)
                        .foregroundStyle(.orange)
                        .background(.orange.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 10))
                        .multilineTextAlignment(.center)
                        .gesture(TapGesture().onEnded({ _ in
                            viewModel.isMoreProtein.toggle()
                        }))
                    Text("чем")
                    TextField("число", text: $viewModel.protein)
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                        .keyboardType(.numberPad)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.background))
                        .multilineTextAlignment(.center)
                        .frame(width: 90)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                HStack {
                    Text("Жиров")
                    Spacer()
                    Text(viewModel.isMoreFats ? "больше" : "меньше")
                        .padding(.vertical, 6)
                        .padding(.horizontal, 8)
                        .frame(width: 80)
                        .foregroundStyle(.orange)
                        .background(.orange.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 10))
                        .multilineTextAlignment(.center)
                        .gesture(TapGesture().onEnded({ _ in
                            viewModel.isMoreFats.toggle()
                        }))
                    Text("чем")
                    TextField("число", text: $viewModel.fats)
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                        .keyboardType(.numberPad)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.background))
                        .multilineTextAlignment(.center)
                        .frame(width: 90)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                HStack {
                    Text("Углеводов")
                    Spacer()
                    Text(viewModel.isMoreCarbohydrates ? "больше" : "меньше")
                        .padding(.vertical, 6)
                        .padding(.horizontal, 8)
                        .frame(width: 80)
                        .foregroundStyle(.orange)
                        .background(.orange.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 10))
                        .multilineTextAlignment(.center)
                        .gesture(TapGesture().onEnded({ _ in
                            viewModel.isMoreCarbohydrates.toggle()
                        }))
                    Text("чем")
                    TextField("число", text: $viewModel.carbohydrates)
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                        .keyboardType(.numberPad)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.background))
                        .multilineTextAlignment(.center)
                        .frame(width: 90)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            } header: {
                HStack {
                    Text("Пищевая ценность")
                    Spacer()
                    Button {
                        viewModel.calories = ""
                        viewModel.carbohydrates = ""
                        viewModel.fats = ""
                        viewModel.protein = ""
                    } label: {
                        Text("Очистить")
                            .textCase(.none)
                            .font(.caption)
                    }
                }
            }
            Section {
                if (viewModel.isTimeSetted) {
                    HStack {
                        if (viewModel.hours == 0) {
                            Text("Меньше чем \(viewModel.minutes) минут")
                        } else {
                            Text("Меньше чем \(viewModel.hours) ч. \(viewModel.minutes) мин.")
                        }
                        Spacer()
                        Button {
                            viewModel.isTimeSetted = false
                            viewModel.isTimeSetting = true
                        } label: {
                            Text("Изменить")
                        }
                    }
                } else {
                    if (viewModel.isTimeSetting) {
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                Text("Часы")
                                Picker("Hours", selection: $viewModel.hours) {
                                    ForEach(0 ..< 100) { hour in
                                        Text("\(hour)")
                                    }
                                }
                                .pickerStyle(.wheel)
                                .clipped()
                                Spacer()
                                Text("Минуты")
                                Picker("Minutes", selection: $viewModel.minutes) {
                                    ForEach(0 ..< 60) { minute in
                                        Text("\(minute)")
                                    }
                                }
                                .pickerStyle(.wheel)
                                .clipped()
                            }
                            Button {
                                viewModel.isTimeSetted = true
                                viewModel.isTimeSetting = false
                                viewModel.durationSet()
                            } label: {
                                Text("Установить")
                            }
                        }
                        .listRowBackground(Color.clear)
                    } else {
                        Button {
                            viewModel.isTimeSetting = true
                        } label: {
                            Text("Установить время")
                        }
                        .frame(width: UIScreen.main.bounds.width, alignment: .center)
                        .listRowBackground(Color.orange.opacity(0.1))
                    }
                }
            } header: {
                HStack {
                    Text("filters.time.cook".localized)
                    Spacer()
                    Button {
                        viewModel.isTimeSetted = false
                        viewModel.isTimeSetting = false
                        viewModel.duration = ""
                    } label: {
                        Text("Очистить")
                            .textCase(.none)
                            .font(.caption)
                    }
                }
            }
            Section {
                VStack {
                    HStack {
                        TextField("filters.enter.ingridient".localized, text: $viewModel.containsTextField)
                        VStack {
                            Image(systemName: "plus")
                                .resizable()
                                .tint(.white)
                                .fontWeight(.semibold)
                                .frame(width: 20, height: 20)
                        }
                        .gesture(TapGesture().onEnded {
                            viewModel.addToContains(word: viewModel.containsTextField)
                            viewModel.containsTextField = ""
                        })
                        .frame(width: 28, height: 28)
                        .background(.orange, in: .rect(cornerRadius: 4))
                        .opacity(viewModel.containsTextField == "" ? 0 : 1)
                        .foregroundStyle(.white)
                    }
                    if (!viewModel.contains.isEmpty) {
                        HStack (spacing: 4) {
                            ForEach (viewModel.contains.indices, id: \.self) {index in
                                Text(viewModel.contains[index])
                                    .foregroundStyle(.white)
                                    .font(.caption)
                                .padding(8)
                                .background(.orange)
                                .clipShape(.capsule)
                                .gesture(TapGesture().onEnded({
                                    viewModel.removeFromContains(word: viewModel.contains[index])
                                }))
                            }
                            Spacer()
                        }
                    }
                }
            } header: {
                HStack {
                    Text("filters.contains".localized)
                    Spacer()
                    Button {
                        viewModel.containsTextField = ""
                        viewModel.contains = []
                    } label: {
                        Text("Очистить")
                            .textCase(.none)
                            .font(.caption)
                    }
                }
            }
            Section {
                VStack {
                    HStack {
                        TextField("filters.enter.ingridient".localized, text: $viewModel.notContainsTextField)
                        VStack {
                            Image(systemName: "plus")
                                .resizable()
                                .tint(.white)
                                .fontWeight(.semibold)
                                .frame(width: 20, height: 20)
                        }
                        .gesture(TapGesture().onEnded {
                            viewModel.addToNotContains(word: viewModel.notContainsTextField)
                            viewModel.notContainsTextField = ""
                        })
                        .frame(width: 28, height: 28)
                        .background(.orange, in: .rect(cornerRadius: 4))
                        .opacity(viewModel.notContainsTextField == "" ? 0 : 1)
                        .foregroundStyle(.white)
                    }
                    if (!viewModel.notContains.isEmpty) {
                        HStack (spacing: 4) {
                            ForEach (viewModel.notContains.indices, id: \.self) {index in
                                Text(viewModel.notContains[index])
                                    .foregroundStyle(.white)
                                    .font(.caption)
                                .padding(8)
                                .background(.orange)
                                .clipShape(.capsule)
                                .gesture(TapGesture().onEnded({
                                    viewModel.removeFromNotContains(word: viewModel.notContains[index])
                                }))
                            }
                            Spacer()
                        }
                    }
                }
            } header: {
                HStack {
                    Text("filters.not.contains".localized)
                    Spacer()
                    Button {
                        viewModel.notContainsTextField = ""
                        viewModel.notContains = []
                    } label: {
                        Text("Очистить")
                            .textCase(.none)
                            .font(.caption)
                    }
                }
            }
//            Section {
//                DietCellView()
//                DietCellView()
//                DietCellView()
//                DietCellView()
//                DietCellView()
//            } header: {
//                Text("filters.find.diet".localized)
//            }
        }
        .listSectionSpacing(8)
        .overlay(
            Button  {
                viewModel.isLoading = true
                self.presentationMode.wrappedValue.dismiss()
                viewModel.findRecipesByFilter()
            } label: {
                HStack {
                    Text("filters.accept.button".localized)
                }
                .tint(.white)
                .fontWeight(.semibold)
            }
                .frame(width: 200, height: 50)
                .background(.orange, in: .rect(cornerRadius: 14)),
            alignment: .bottom
        )
    }
}
