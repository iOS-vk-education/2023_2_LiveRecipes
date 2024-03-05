//
//  WeakBox.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation

protocol WeakBox: AnyObject {
    var weakBoxHolder: [String: WeakContainer<AnyObject>] { get set }
}

extension WeakBox {
    func weakBox<T>(_ configure: () -> T) -> T {
        let key = ObjectKey(T.self).key
        if let object = self.weakBoxHolder[key]?.value as? T {
            return object
        }
        let object = configure()
        weakBoxHolder[key] = WeakContainer(value: object as AnyObject)
        return object
    }
}
