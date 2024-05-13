//
//  CreationView.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 26.03.2024.
//

import SwiftUI
import Combine

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
    @State private var selectedDishStep: DishStep?
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    @State private var isTimeOpen = false
    @State private var isStepModalOpen = false
    @State private var image: UIImage?
    @State private var isImagePickerOn: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("creation.label.dishName".localized)) {
                HStack {
                    TextField("creation.placeholder.name", text: $textTitle)
                }
            }
            Section(header: Text("creation.label.description".localized)) {
                HStack {
                    TextEditor(text: $textDescription)
                        .frame(minHeight: 100)
                }
            }
            imageView()
            timeView()
            nutritionView()
            compositionView()
            stepView()
            buttonView()
        }
        .navigationTitle("creation.title".localized)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    @ViewBuilder
    func imageView() -> some View {
        Section(header: Text("creation.label.addPhoto".localized)) {
            HStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .scaledToFill()
                        .clipShape(.rect(cornerRadius: 12))
                        .clipped()
                } else {
                    Image(systemName: "photo.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .padding(EdgeInsets(top: 15, leading: 25, bottom: 25, trailing: 15))
                        .foregroundColor(.gray)
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
    }
    @ViewBuilder
    func buttonView() -> some View {
        Section {
            HStack {
                Button(action: {
                    print("creation.button.save".localized)
                    viewState.createDish(
                        textTitle: textTitle,
                        textDescription: textDescription,
                        timeToPrepare: (hours * 60 * 60) + (minutes * 60) + seconds,
                        textButritionalValueCalories: textButritionalValueCalories,
                        textButritionalValueProteins: textButritionalValueProteins,
                        textButritionalValueFats: textButritionalValueFats,
                        textButritionalValueCarbohydrates: textButritionalValueCarbohydrates,
                        image: image)
                }) {
                    Text("creation.button.save".localized)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(PlainButtonStyle())
                .frame(maxWidth: .infinity)
                .animation(.easeInOut, value: 0.2)
            }
        }
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.orange)
    }
    @ViewBuilder
    func timeView() -> some View {
        Section(header: Text("creation.label.timeToPrepare".localized)) {
            if isTimeOpen {
                HStack(spacing: 0) {
                    Picker("Hours", selection: $hours) {
                        ForEach(0 ..< 24) { hour in
                            Text("\(hour)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding(.trailing, -15)
                    .clipped()
                    Picker("Minutes", selection: $minutes) {
                        ForEach(0 ..< 60) { minute in
                            Text("\(minute)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding(.horizontal, -15)
                    .clipped()
                    Picker("Seconds", selection: $seconds) {
                        ForEach(0 ..< 60) { second in
                            Text("\(second)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding(.leading, -15)
                    .clipped()
                }
                .padding()
            } else {
                HStack {
                    Button(action: {
                        isTimeOpen = true
                    }) {
                        let isTimeSet = (
                            seconds == 0 &&
                            minutes == 0 &&
                            hours == 0
                        )
                        let hoursString = String(format: "%02d", hours)
                        let minutesString = String(format: "%02d", minutes)
                        let secondsString = String(format: "%02d", seconds)
                        Text(isTimeSet ? "creation.button.setTime".localized : "\(hoursString) \(" : ") \(minutesString) \(" : ")\(secondsString)")
                            .foregroundColor(isTimeSet ? Color.orange : Color.secondary)
                            .font(isTimeSet ? .system(.body) : .system(size: 18))
                            .cornerRadius(12)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(maxWidth: .infinity)
                    .animation(.easeInOut, value: 0.2)
                        
                }
            }
        }
        if isTimeOpen {
            Section {
                HStack {
                    Button(action: {
                        print("creation.button.saveTime".localized)
                        isTimeOpen = false
                    }) {
                        Text("creation.button.saveTime".localized)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(12)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(maxWidth: .infinity)
                    .animation(.easeInOut, value: 0.2)
                }
                .background(Color.orange)
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.orange)
        }
    }
    @ViewBuilder
    func nutritionView() -> some View  {
        Section(header: Text("creation.label.nutritionalValue".localized)) {
            HStack {
                Text("creation.nutritionalValue.calories".localized)
                    .foregroundColor(Color(.black))
                    .frame(width: 170, alignment: .leading)
                TextField("", text: $textButritionalValueCalories)
                    .foregroundColor(Color.secondary)
            }
            HStack {
                Text("creation.nutritionalValue.proteins".localized)
                    .foregroundColor(Color(.black))
                    .frame(width: 170, alignment: .leading)
                TextField("", text: $textButritionalValueProteins)
                    .foregroundColor(Color.secondary)
            }
            HStack {
                Text("creation.nutritionalValue.fats".localized)
                    .foregroundColor(Color(.black))
                    .frame(width: 170, alignment: .leading)
                TextField("", text: $textButritionalValueFats)
                    .foregroundColor(Color.secondary)
            }
            HStack {
                Text("creation.nutritionalValue.carbohydrates".localized)
                    .foregroundColor(Color(.black))
                    .frame(width: 170, alignment: .leading)
                TextField("", text: $textButritionalValueCarbohydrates)
                    .foregroundColor(Color.secondary)
            }
        }
    }
    @ViewBuilder
    func compositionView() -> some View  {
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
                        .foregroundColor(Color.secondary)
                }
            }
            .onDelete(perform: { indexSet in
                if let index = indexSet.first {
                    print("delete index: \(index)")
                    viewState.deleteDishComposition(index: index)
                }
            })
        }
    }
    @ViewBuilder
    func stepView() -> some View  {
        Section(header:
            HStack {
                Text("creation.label.steps".localized)
                if viewState.dishSteps.count != 0 {
                    Spacer()
                    Text("creation.controle.addStep".localized)
                        .font(.system(size: 8, weight: .regular, design: .default))
                        .onTapGesture {
                            selectedDishStep = nil
                            isStepModalOpen = true
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
                    if !isStepModalOpen {
                        selectedDishStep = nil
                        isStepModalOpen = true
                    }
                }
            } else {
                ForEach(Array(viewState.dishSteps.enumerated()), id: \.element.id) { index, dishStep in
                    HStack {
                        Text(dishStep.title)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .onTapGesture {
                        if !isStepModalOpen {
                            selectedDishStep = dishStep
                            isStepModalOpen = true
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    if let index = indexSet.first {
                        viewState.deleteStep(index: index)
                    }
                })
            }
        }
        .sheet(isPresented: $isStepModalOpen, onDismiss: {
            isStepModalOpen = false
            selectedDishStep = nil
        }, content: {
            StepView(dishStep: selectedDishStep, creationViewModel: viewState)
        })
    }
}

