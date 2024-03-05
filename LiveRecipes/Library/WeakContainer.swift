//
//  WeakContainer.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation

class WeakContainer<T> {
    fileprivate weak var _value: AnyObject?
    var value: T? {
        set { self._value = newValue as AnyObject }
        get { return _value as? T }
    }

    init(value: T) {
        self._value = value as AnyObject
    }
}
