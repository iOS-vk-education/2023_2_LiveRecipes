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
                    //.background(Color.red)
                Text(dishStep.title)
                    .frame(maxWidth: .infinity)
                    //.background(Color.green)
                Image(systemName: "xmark.circle.fill")
                    .onTapGesture {
                        closeModal()
                    }
                    .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 0))
                    //.background(Color.yellow)
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
                        Button(action: {
                            print("creation.button.save".localized)
                            creationViewModel.editStepComposition(id: dishStep.id, title: textTitle, description: textDescription, photo: nil)
                            closeModal()
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
    }
    private func closeModal() {
        self.presentation.wrappedValue.dismiss()
    }
}
