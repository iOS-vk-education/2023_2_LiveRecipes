//
//  NavigationServiceType.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation

protocol NavigationServiceType: ObservableObject, Identifiable {
    var items: [Views] { get set }
    var modalView: Views? { get set }
    var alert: CustomAlert? { get set }
}
