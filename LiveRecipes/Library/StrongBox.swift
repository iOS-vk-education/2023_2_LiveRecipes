//
//  StrongBox.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation

protocol StrongBox: AnyObject {
    var strongBoxHolder: [String: AnyObject] { get set }
}

extension StrongBox {
    func strongBox<T>(_ configure: () -> T) -> T {
        let key = ObjectKey(T.self).key
        if let object = self.strongBoxHolder[key] {
            // swiftlint:disable force_cast
            return object as! T
            // swiftlint:enable force_cast
        }
        let object = configure()
        strongBoxHolder[key] = object as AnyObject
        return object
    }
}
