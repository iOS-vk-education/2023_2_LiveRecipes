//
//  StepView.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 14.04.2024.
//

import SwiftUI

struct StepView: View {
    @Environment(\.presentationMode) var presentation
    var dishStep: DishStep? {
        didSet {
            print("dishStep did set")
        }
    }
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
                        saveStep()
                    }
                Text(dishStep?.title ?? "creation.newStep".localized)
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
                        TextField("creation.placeholder.name", text:  $textTitle)
                    }
                    .onAppear {
                        if let dishStep = dishStep {
                            textTitle = dishStep.title
                        }
                    }
                }
                Section(header: Text("creation.label.description".localized)) {
                    HStack {
                        TextField("creation.placeholder.stepDescription".localized, text: $textDescription)
                    }
                    .onAppear {
                        if let dishStep = dishStep {
                            textDescription = dishStep.description
                        }
                    }
                }
                imageView()
                Section {
                    HStack {
                        buttonView()
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.orange)
            }
        }
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
            .onAppear {
                if let dishStep = dishStep, let photo = dishStep.photo {
                    image = photo
                }
            }
            .sheet(isPresented: $isImagePickerOn) {
                ImagePicker(image: $image, isImagePickerOn: $isImagePickerOn)
            }
        }
    }
    @ViewBuilder
    func buttonView() -> some View {
        Button(action: {
            print("creation.button.save".localized)
            saveStep()
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
    private func saveStep() {
        if let dishStep = dishStep {
            creationViewModel.editStep(id: dishStep.id, title: textTitle, description: textDescription, photo: image)
        } else {
            creationViewModel.addStep(title: textTitle, description: textDescription, photo: image)
        }
        closeModal()
    }
    private func closeModal() {
        self.presentation.wrappedValue.dismiss()
    }
}
