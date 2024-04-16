//
//  StepView.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 14.04.2024.
//

import SwiftUI

struct StepView: View {
    @Environment(\.presentationMode) var presentation
    var dishStep: DishStep
    var creationViewModel: CreationViewModel
    @State private var textTitle = ""
    @State private var textDescription = ""
    @State private var image: UIImage?
    @State private var isImagePickerOn: Bool = false

    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Text("creation.button.save".localized)
                    .onTapGesture {
                        closeModal()
                    }
                Text(dishStep.title)
                    .frame(maxWidth: .infinity)
                Image(systemName: "xmark.circle.fill")
                    .onTapGesture {
                        closeModal()
                    }
                    .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 0))
            }
            .padding()
            List {
                Section(header: Text("creation.label.stepName".localized)) {
                    HStack {
                        TextField("creation.placeholder.name", text: $textTitle)
                    }
                }
                Section(header: Text("creation.label.description".localized)) {
                    HStack {
                        TextField("creation.placeholder.stepDescription".localized, text: $textDescription)
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
                Section {
                    HStack {
                        buttonView()
                    }
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(Color.orange)
            }
        }
    }
    @ViewBuilder
    func buttonView() -> some View {
        Button(action: {
            print("creation.button.save".localized)
            
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
    private func saveStep() -> Bool {
        return true
    }
    private func closeModal() {
        self.presentation.wrappedValue.dismiss()
    }
}
