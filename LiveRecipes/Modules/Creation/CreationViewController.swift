//
//  CreationViewController.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 13.04.2024.
//

import UIKit
import SwiftUI

struct CreationViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<CreationViewControllerWrapper>) -> UIViewController {
        let viewController = CreationViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CreationViewControllerWrapper>) {}
}

class CreationViewController: UIViewController {

    /*private var dishTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.text = "!"
        return label
    }()*/
    
    

}
