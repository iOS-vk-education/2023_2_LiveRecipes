//
//  KeyWordsView.swift
//  LiveRecipes
//
//  Created by Александр Денисов on 01.04.2024.
//

import SwiftUI

//struct KeyWordsView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @StateObject var viewModel: RecipesViewModel
//    @State private var searchText = ""
//    
//    var body: some View {
//        NavigationView {
//            keyWordsViewContent()
//                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
//                .navigationTitle("keywords.title".localized)
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem(placement: .topBarTrailing) {
//                        Button {
//                            self.presentationMode.wrappedValue.dismiss()
//                            viewModel.sortKeyWordsByChoose()
//                        } label: {
//                            VStack {
//                                Image(systemName: "xmark")
//                                    .imageScale(.small)
//                                    .fontWeight(.semibold)
//                                    .foregroundStyle(Color(red: 0.2353, green: 0.2353, blue: 0.2627, opacity: 0.6))
//                            }
//                            .frame(width: 30, height: 30)
//                            .background(Color(UIColor.secondarySystemBackground))
//                            .clipShape(.circle)
//                        }
//                    }
//                }
//        }
//    }
//    
//    @ViewBuilder
//    func keyWordsViewContent() -> some View {
//            if (viewModel.keyWords.isEmpty) {
//                Text("keywords.error.message".localized)
//            } else {
//                ScrollView {
//                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()],
//                              content: {
//                        ForEach (viewModel.keyWords.indices, id: \.self) { index in
//                            VStack {
//                                Button(action: {
//                                    viewModel.keyWords[index].choose()
//                                }, label: {
//                                    Text(viewModel.keyWords[index].keyWord)
//                                        .tint(viewModel.keyWords[index].isChoosed ? .white : .black)
//                                        .font(.caption)
//                                        .padding(8)
//                                        .background(Color(viewModel.keyWords[index].isChoosed ? UIColor.orange : UIColor.secondarySystemBackground))
//                                        .clipShape(.capsule)
//                                })
//                            }
//                        }
//                    })
//                }
//                .overlay(
//                    Button  {
//                        self.presentationMode.wrappedValue.dismiss()
//                        viewModel.sortKeyWordsByChoose()
//                    } label: {
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .imageScale(.medium)
//                            Text("keywords.search.button".localized)
//                        }
//                        .tint(.white)
//                        .fontWeight(.semibold)
//                    }
//                        .frame(width: 200, height: 50)
//                        .background(.orange, in: .rect(cornerRadius: 14)),
//                    alignment: .bottom
//                )
//            }
//        }
//}



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
                                }, label: {
                                    Text(viewModel.keyWords[index].keyWord)
                                        .tint(viewModel.keyWords[index].isChoosed ? .white : .black)
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


//пытался сделать нормально, не через LazyVGrid

//                LazyVStack {
//                    GeometryReader { proxy in
//                        var width = UIScreen.main.bounds.size.width
//                        var height = UIScreen.main.bounds.size.height
//                        ZStack(alignment: .topLeading) {
//                            ForEach (viewModel.keyWords.indices, id: \.self) { index in
//                                VStack {
//                                    Button(action: {
//                                        viewModel.keyWords[index].choose()
//                                    }, label: {
//                                        Text(viewModel.keyWords[index].keyWord)
//                                            .tint(viewModel.keyWords[index].isChoosed ? .white : .black)
//                                            .font(.caption)
//                                            .padding(8)
//                                            .background(Color(viewModel.keyWords[index].isChoosed ? UIColor.orange : UIColor.secondarySystemBackground))
//                                            .clipShape(.capsule)
//                                    })
//                                    .padding(4)
//                                }
//                                .alignmentGuide(.top, computeValue: {d in
//                                    let result = height
//                                    if index == viewModel.keyWords.endIndex {
//                                        height = 0
//                                    }
//                                    return result
//                                })
//                                .alignmentGuide(.leading, computeValue: { d in
//                                    if (abs(width - d.width) > proxy.size.width - 24)
//                                    {
//                                        width = 0
//                                        height -= d.height
//                                    }
//                                    let result = width
//                                    if index == viewModel.keyWords.endIndex {
//                                        width = 0
//                                    } else {
//                                        width -= d.width
//                                    }
//                                    return result
//                                })
//
//                                .padding(.horizontal, 8)
//                            }
//                        }
//                    }
//                }
//            }
//            .scrollIndicators(.hidden)
//        }
//    }
//
//    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
//        return GeometryReader { geometry -> Color in
//            let rect = geometry.frame(in: .local)
//            DispatchQueue.main.async {
//                binding.wrappedValue = rect.size.height
//            }
//            return .clear
//                        }
