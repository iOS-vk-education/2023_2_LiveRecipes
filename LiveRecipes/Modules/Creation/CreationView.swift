//
//  CreationView.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 26.03.2024.
//

import SwiftUI

struct CreationView: View {
    @StateObject var viewState: CreationViewModel
    @State private var textTitle = ""
    @State private var textDescription = ""
    @State private var textButritionalValueCalories = ""
    @State private var textButritionalValueProteins = ""
    @State private var textButritionalValueFats = ""
    @State private var textButritionalValueCarbohydrates = ""
    @State private var textNewProduct = ""
    @State private var textNewQuantity = ""
    @State private var dishStep: DishStep? = nil {
        didSet {
            print("is changed")
            print(dishStep)
        }
    }
    @State private var image: UIImage?
    @State private var isImagePickerOn: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("creation.label.dishName".localized)) {
                    HStack {
                        TextField("creation.placeholder.name", text: $textTitle)
                    }
                }
                Section(header: Text("creation.label.description".localized)) {
                    HStack {
                        TextField("creation.placeholder.dishDescription".localized, text: $textDescription)
                    }
                }
                Section(header: Text("creation.label.addPhoto".localized)) {
                    HStack {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Image(systemName: "photo.badge.plus")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .onTapGesture {
                        print("ImagePicker")
                        self.isImagePickerOn = true
                    }
                    .sheet(isPresented: $isImagePickerOn) {
                        ImagePicker(image: $image, isImagePickerOn: $isImagePickerOn)
                    }
                }
                Section(header: Text("creation.label.timeToPrepare".localized)) {
                    HStack {
                    }
                }
                Section(header: Text("creation.label.nutritionalValue".localized)) {
                    HStack {
                        Text("creation.nutritionalValue.calories".localized)
                            .foregroundColor(Color(.black))
                            .frame(width: 170, alignment: .leading)
                        TextField("", text: $textButritionalValueCalories)
                            .foregroundColor(Color(.gray))
                    }
                    HStack {
                        Text("creation.nutritionalValue.proteins".localized)
                            .foregroundColor(Color(.black))
                            .frame(width: 170, alignment: .leading)
                        TextField("", text: $textButritionalValueProteins)
                            .foregroundColor(Color(.gray))
                    }
                    HStack {
                        Text("creation.nutritionalValue.fats".localized)
                            .foregroundColor(Color(.black))
                            .frame(width: 170, alignment: .leading)
                        TextField("", text: $textButritionalValueFats)
                            .foregroundColor(Color(.gray))
                    }
                    HStack {
                        Text("creation.nutritionalValue.carbohydrates".localized)
                            .foregroundColor(Color(.black))
                            .frame(width: 170, alignment: .leading)
                        TextField("", text: $textButritionalValueCarbohydrates)
                            .foregroundColor(Color(.gray))
                    }
                }
                Section(header: 
                    HStack {
                        Text("creation.label.composition".localized)
                        Spacer()
                        Text("creation.controle.addProduct".localized)
                        .font(.system(size: 8, weight: .regular, design: .default))
                        .onTapGesture {
                            viewState.addDishComposition(product: "", quantity: "")
                        }
                    }
                ) {
                    ForEach(Array(viewState.dishComposition.enumerated()), id: \.element.id) { index, composition in
                        HStack {
                            TextField("creation.placeholder.product".localized, text: $viewState.dishComposition[index].product)
                                .foregroundColor(Color(.black))
                            TextField("creation.placeholder.quantity".localized, text: $viewState.dishComposition[index].quantity)
                                .foregroundColor(Color(.gray))
                        }
                    }
                    .onDelete(perform: { indexSet in
                        if let index = indexSet.first {
                            print("delete index: \(index)")
                            viewState.deleteDishComposition(index: index)
                        }
                    })
                }
                Section(header:
                    HStack {
                        Text("creation.label.steps".localized)
                        if viewState.dishSteps.count != 0 {
                            Spacer()
                            Text("creation.controle.addStep".localized)
                                .font(.system(size: 8, weight: .regular, design: .default))
                                .onTapGesture {
                                    viewState.addEmptyStep()
                                }
                        }
                    }
                ) {
                    if viewState.dishSteps.count == 0 {
                        HStack {
                            Text("creation.controle.addStep".localized)
                                .frame(maxWidth: .infinity)
                        }
                        .onTapGesture {
                            viewState.addEmptyStep()
                            self.dishStep = DishStep(id: 0, title: "creation.firstStep".localized, description: "")
                        }
                        .sheet(item: $dishStep) { dish in
                            StepView(dishStep: dish, creationViewModel: viewState)
                        }
                    } else {
                        ForEach(Array(viewState.dishSteps.enumerated()), id: \.element.id) { index, step in
                            HStack {
                                Text(step.title)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .onTapGesture {
                                self.dishStep = step
                            }
                            .sheet(item: $dishStep) { dish in
                                StepView(dishStep: dish, creationViewModel: viewState)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            if let index = indexSet.first {
                                viewState.deleteStepComposition(index: index)
                            }
                        })
                    }
                }
                Section {
                    HStack {
                        Button(action: {
                            print("creation.button.save".localized)
                            viewState.createDish(
                                textTitle: textTitle,
                                textDescription: textDescription,
                                timeToPrepare: 0,
                                textButritionalValueCalories: textButritionalValueCalories,
                                textButritionalValueProteins: textButritionalValueProteins,
                                textButritionalValueFats: textButritionalValueFats,
                                textButritionalValueCarbohydrates: textButritionalValueCarbohydrates,
                                image: image)
                        }) {
                            Text("creation.button.save".localized)
                            //.foregroundColor(.white)
                            .foregroundColor(Color.orange)
                            //.background(Color.orange)
                            .cornerRadius(12)
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(maxWidth: .infinity)
                        .listRowInsets(EdgeInsets())
                        //.listRowBackground(Color.clear)
                        .animation(.easeInOut, value: 0.2)
                        //.background(Color.orange)
                    }
                }
                
            }
            
        }
        .navigationTitle("creation.title".localized)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

