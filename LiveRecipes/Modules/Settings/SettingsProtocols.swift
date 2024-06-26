//
//  SettingsProtocols.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 11.04.2024.
//

import Foundation

protocol SettingsViewModelProtocol {
    func clearFavorites() -> Void
    func clearMyRecipes () -> Void
    
}

protocol SettingsModelProtocol {}

protocol SettingsViewProtocol {}
