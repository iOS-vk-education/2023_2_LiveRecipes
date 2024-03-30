//
//  CreationViewModel.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 26.03.2024.
//

import Foundation

final class CreationViewModel: ObservableObject, CreationViewModelProtocol {
    var model: CreationModelProtocol

    init(creationModel: CreationModelProtocol) {
        self.model = creationModel
    }
}
