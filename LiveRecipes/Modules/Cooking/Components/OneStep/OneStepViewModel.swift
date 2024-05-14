//
//  OneStepViewModel.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 14.05.2024.
//

import Foundation
import SwiftUI


struct OneStepModel {
  @State var isTimerOnView: Bool = false 
  @State var isLanded: Bool = false
  @State var isDatePicker: Bool = false
  @State var blurIsActive: Bool = false
  @State var firstAppearence: Bool = true
  let stepNumber: Int
  let steps: [[String]]
  let dishName: String
  let dishType: String
}

final class OneStepViewModel: ObservableObject, SettingsViewModelProtocol {
    @Published var isTimerOnView: Bool
    @Published var isLanded: Bool
    @Published var isDatePicker: Bool
    @Published var blurIsActive: Bool
    @Published var firstAppearence: Bool
    var stepNumber: Int
    var steps: [[String]]
    var dishName: String
    var dishType: String

    init(model: OneStepModel) {
        self.stepNumber = model.stepNumber
        self.steps = model.steps
        self.dishName = model.dishName
        self.dishType = model.dishType
        
        self.isTimerOnView = false
        self.isLanded = false
        self.isDatePicker = false
        self.blurIsActive = false
        self.firstAppearence = true
    }
    
    func updatePublished() {
        self.isTimerOnView = false
        self.isLanded = false
        self.isDatePicker = false
        self.blurIsActive = false
        self.firstAppearence = true
    }
    
    func setRecipe(model: RecipeDTO) {
        self.stepNumber = 1
        self.steps = model.steps
        self.dishName = model.name
        self.dishType = model.tag
        
        self.isTimerOnView = false
        self.isLanded = false
        self.isDatePicker = false
        self.blurIsActive = false
        self.firstAppearence = true
    }
}
