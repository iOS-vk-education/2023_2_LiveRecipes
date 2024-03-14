//
//  RecipesView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import UIKit
import Swinject
import SwiftUI

struct RecipesViewControllerBridge: UIViewControllerRepresentable {
    var view: RecipesViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return view
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

final class RecipesViewController: UIViewController {
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Press me", for: .normal)
        button.addTarget(nil, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    @objc
    func buttonPressed() {
        print("PRESSED")

//        let nav = Assembler.sharedAssembler.resolver.resolve(NavigationService.self)
        StubNavigation.stub.modalView = .cooking
        StubNavigation.stub.alert = .defaultAlert(yesAction: {}, noAction: {})
        ApplicationViewBuilder.stub.build(view: .cooking)
        StubNavigation.stub.
        StubNavigation.stub.items.append(.cooking)
        print(StubNavigation.stub.items)
//        StubNavigation.n
//        nav.append(.cooking)
//        print(nav?.id)
//        nav?.items.append(.cooking)
//        print(nav?.items)
//        nav?.alert = .defaultAlert(yesAction: {}, noAction: {})
//        print(nav?.$items)
//        nav?.modalView = .cooking
//        nav?.objectWillChange = true
//        nav?.id
//        nav?.$modalView = (any View)()
        
//        nav?.items.append(.cooking)
        print("DEPRESSED")
    }

    var presenter: RecipesPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        view.backgroundColor = .red
        presenter?.setupInitialState()
    }
}

extension RecipesViewController: RecipesViewProtocol {
    func update() {
        view.backgroundColor = presenter?.backgroundC
        print("updated?")
    }
}

#Preview {
    ApplicationViewBuilder.stub.build(view: .main)
}
