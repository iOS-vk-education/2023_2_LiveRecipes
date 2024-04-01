//
//  KeyWordsView.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 01.04.2024.
//

import SwiftUI

struct KeyWordsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: RecipesViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            keyWordsView()
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .navigationTitle("Ключевые слова")
                .navigationBarTitleDisplayMode(.inline)
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
        }
    }
    
//    func createGrid(keyWords: [KeyWord]) -> [GridItem] {
//        var items: [GridItem] = []
//        let sizeOfScreen = UIScreen.main.bounds.size.width
//        ForEach(viewModel.keyWords.indices, id: \.self) {i in
//            GeometryReader {proxy in
//                Button(action: {
//                    viewModel.keyWords[i].choose()
//                }, label: {
//                    Text(viewModel.keyWords[i].keyWord)
//                        .tint(viewModel.keyWords[i].isChoosed ? .white : .black)
//                        .font(.caption)
//                        .fontWeight(viewModel.keyWords[i].isChoosed ? .bold : .regular)
//                })
//                .padding(8)
//            }
//        }
//        return items
//    }
    
    @ViewBuilder
    func keyWordsView() -> some View {
        if (viewModel.keyWords.isEmpty) {
            Text("Ошибка загрузки данных")
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 360))], alignment: .center) {
                    ForEach (viewModel.keyWords.indices, id: \.self) { index in
                        Button(action: {
                            viewModel.keyWords[index].choose()
                        }, label: {
                            Text(viewModel.keyWords[index].keyWord)
                                .tint(viewModel.keyWords[index].isChoosed ? .white : .black)
                                .font(.caption)
                                .fontWeight(viewModel.keyWords[index].isChoosed ? .bold : .regular)
                        })
                        .padding(8)
                        .background(Color(viewModel.keyWords[index].isChoosed ? UIColor.orange : UIColor.secondarySystemBackground))
                        .clipShape(.capsule)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
