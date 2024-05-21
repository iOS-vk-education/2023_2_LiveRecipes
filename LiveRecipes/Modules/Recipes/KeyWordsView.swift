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
            keyWordsViewContent()
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .navigationTitle("keywords.title".localized)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                            viewModel.sortKeyWordsByChoose()
                        } label: {
                            VStack {
                                Image(systemName: "xmark")
                                    .imageScale(.small)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(red: 0.2353, green: 0.2353, blue: 0.2627, opacity: 1))
                            }
                            .frame(width: 30, height: 30)
                            .background(Color(UIColor.secondarySystemBackground))
                            .clipShape(.circle)
                        }
                    }
                }
        }
    }
    
    @ViewBuilder
    func keyWordsViewContent() -> some View {
            if (viewModel.keyWords.isEmpty) {
                Text("keywords.error.message".localized)
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()],
                              content: {
                        ForEach (viewModel.keyWords.indices, id: \.self) { index in
                            VStack {
                                Button(action: {
                                    viewModel.keyWords[index].choose()
                                    viewModel.keywordSearch(word: viewModel.keyWords[index])
                                }, label: {
                                    Text(viewModel.keyWords[index].keyWord)
                                        .tint(viewModel.keyWords[index].isChoosed ? .white : Color(uiColor: .label))
                                        .font(.caption)
                                        .padding(8)
                                        .background(Color(viewModel.keyWords[index].isChoosed ? UIColor.orange : UIColor.secondarySystemBackground))
                                        .clipShape(.capsule)
                                })
                            }
                        }
                    })
                }
                .overlay(
                    Button  {
                        self.presentationMode.wrappedValue.dismiss()
                        viewModel.sortKeyWordsByChoose()
                        viewModel.isLoading = true
                        viewModel.findRecipesByFilter()
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .imageScale(.medium)
                            Text("keywords.search.button".localized)
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
}
