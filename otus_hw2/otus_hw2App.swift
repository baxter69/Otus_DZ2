//
//  otus_hw2App.swift
//  otus_hw2
//
//  Created by Владимир Воротников on 30.12.2025.
//

import SwiftUI
import CoreServices
import KinopoiskAPI

@main
struct otus_hw2App: App {
    @StateObject private var mediator = FilmMediator.shared

    init() {
        configureDependencies()
    }
    var body: some Scene {
        WindowGroup {
            FilmListView()
                .environmentObject(mediator)
        }
    }
}

private func configureDependencies() {
    ServiceLocator.shared.register(service: NetworkService() as NetworkServiceProtocol)
    ServiceLocator.shared.register(service: FilmsService() as FilmsServiceProtocol)
    ServiceLocator.shared.register(service: FilmStore() as FilmStore)
    ServiceLocator.shared.register(service: FilmMediator() as FilmMediator)
}
