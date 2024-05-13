//
//  CreationError.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 17.04.2024.
//

import Foundation

enum CreationError: Error {
    case withoutTitle
    case withoutDescription
    case withoutTime
    case withoutComposition
    func message() -> String {
        switch self {
        case .withoutTitle:
            return "creation.error.withoutTitle".localized
        case .withoutDescription:
            return "creation.error.withoutDescription".localized
        case .withoutTime:
            return "creation.error.withoutTime".localized
        case .withoutComposition:
            return "creation.error.withoutComposition".localized
        }
    }
}
