//
//  OneStepViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 5/13/24.
//

import Foundation
import SwiftUI


struct OneStepModel {
  @State var isTimerOnView: Bool = false // Use default value for clarity
  @State var isLanded: Bool = false
  @State var isDatePicker: Bool = false
  @State var blurIsActive: Bool = false
  @State var firstAppearence: Bool = true // Use default value for clarity
  let stepNumber: Int
  let steps: [[String]]
  let dishName: String
  let dishType: String
}

final class OneStepViewModel: ObservableObject, SettingsViewModelProtocol {
    @State var isTimerOnView = false
    @State var isLanded = false
    @State var isDatePicker = false
    @State var blurIsActive = false
    @State var firstAppearence = true
    var stepNumber: Int
    var steps: [[String]]
    var dishName: String
    var dishType: String

    init(model: OneStepModel) {
        self.stepNumber = model.stepNumber
        self.steps = model.steps
        self.dishName = model.dishName
        self.dishType = model.dishType
    }
    
    func setRecipe(model: RecipeDTO) {
        self.stepNumber = 1
        self.steps = model.steps
        self.dishName = model.name
        self.dishType = model.tag
    }
}
