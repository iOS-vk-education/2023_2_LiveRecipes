//
//  LiveRecipesView.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var navigationService: NavigationService
    @ObservedObject var appViewBuilder: ApplicationViewBuilder

    var body: some View {
        NavigationStack(path: $navigationService.items) {
            appViewBuilder.build(view: .main)
                .navigationDestination(for: Views.self) { path in
                    switch path {
                    default:
                        // swiftlint:disable fatal_error
                        fatalError()
                        // swiftlint:enable fatal_error
                    }
                }
        }
        .fullScreenCover(isPresented: .constant($navigationService.modalView.wrappedValue != nil)) {
            if let modal = navigationService.modalView {
                switch modal {
                default:
                    // swiftlint:disable fatal_error
                    fatalError()
                    // swiftlint:enable fatal_error
                }
            }
        }
        .alert(isPresented: .constant($navigationService.alert.wrappedValue != nil)) {
            switch navigationService.alert {
            case .defaultAlert(let yesAction, let noAction):
                return Alert(title: Text("alert.title"),
                             primaryButton: .default(Text("alert.yes"), action: yesAction),
                             secondaryButton: .destructive(Text("alert.no"), action: noAction))
            case .none:
                // swiftlint:disable fatal_error
                fatalError()
                // swiftlint:enable fatal_error
            }
        }
    }
}
