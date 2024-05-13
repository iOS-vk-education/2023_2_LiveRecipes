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
    @State private var ccal: Float = 0
    @State private var time: Float = 0
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
                    Slider(value: $ccal, in: 0...3000, step: 1)
                    Text("\(Int(ccal))" + "filters.caloricity.enter".localized)
                        .frame(width: 90)
                }
                .listRowBackground(Color.clear)
            } header: {
                Text("filters.caloricity".localized)
            }
            Section {
                HStack {
                    Slider(value: $time, in: 0...240, step: 5)
                    Text(String("\(Int(time))") + "filters.time.enter".localized)
                        .frame(width: 90)
                }
                .listRowBackground(Color.clear)
            } header: {
                Text("filters.time.cook".localized)
            }
            Section {
                TextField("filters.enter.ingridient".localized, text: $contains)
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
                Text("filters.contains".localized)
            }
            Section {
                TextField("filters.enter.ingridient".localized, text: $notContains)
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
                Text("filters.not.contains".localized)
            }
            Section {
                DietCellView()
                DietCellView()
                DietCellView()
                DietCellView()
                DietCellView()
            } header: {
                Text("filters.find.diet".localized)
            }
        }
        .listSectionSpacing(8)
        .overlay(
            Button  {
                self.presentationMode.wrappedValue.dismiss()
                viewModel.sortKeyWordsByChoose()
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
