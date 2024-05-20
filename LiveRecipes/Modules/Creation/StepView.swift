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
            let totalSeconds = dishStep?.stepTime ?? 0
            hours = totalSeconds / 3600
            let remainingSeconds = totalSeconds % 3600
            minutes = remainingSeconds / 60
            seconds = remainingSeconds % 60
        }
    }
    var creationViewModel: CreationViewModel
    @State private var textDescription = ""
    @State private var image: UIImage?
    @State private var isImagePickerOn: Bool = false
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    @State private var isTimeOpen = false

    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Text("creation.button.save".localized)
                    .onTapGesture {
                        saveStep()
                    }
                Text("creation.newStep".localized)
                    .frame(maxWidth: .infinity)
                Image(systemName: "xmark.circle.fill")
                    .onTapGesture {
                        closeModal()
                    }
                    .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 0))
            }
            .padding()
            List {
                /*Section(header: Text("creation.label.stepName".localized)) {
                    HStack {
                        TextField("creation.placeholder.name", text:  $textTitle)
                    }
                    .onAppear {
                        if let dishStep = dishStep {
                            textTitle = dishStep.stepTime
                        }
                    }
                }*/
                Section(header: Text("creation.label.description".localized)) {
                    HStack {
                        TextEditor(text: $textDescription)
                            .frame(minHeight: 100)
                    }
                    .onAppear {
                        if let dishStep = dishStep {
                            textDescription = dishStep.description
                        }
                    }
                }
                timeView()
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
    private func saveStep() {
        let stepTime = (hours * 60 * 60) + (minutes * 60) + seconds
        if let dishStep = dishStep {
            creationViewModel.editStep(id: dishStep.id, stepTime: stepTime, description: textDescription, photo: image)
        } else {
            creationViewModel.addStep(stepTime: stepTime, description: textDescription, photo: image)
        }
        closeModal()
    }
    private func closeModal() {
        self.presentation.wrappedValue.dismiss()
    }
}
