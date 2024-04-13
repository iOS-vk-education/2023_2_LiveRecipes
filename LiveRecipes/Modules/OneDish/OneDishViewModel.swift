//
//  OneDishViewModel.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 30.03.2024.
//

import Foundation

final class OneDishViewModel: ObservableObject, OneDishViewModelProtocol {
    var model: OneDishModelProtocol

    init(oneDishModel: OneDishModelProtocol) {
        self.model = oneDishModel
    }
}
