//
//  Mediator.swift
//  otus_hw2
//
//  Created by Владимир Воротников on 30.12.2025.
//

import Foundation
import Combine
import KinopoiskAPI

final class FilmMediator: ObservableObject {
    static let shared = FilmMediator()
    
    @Published var selectedCategory: FilmsAPI.ModelType_apiV22FilmsCollectionsGet = .topPopularAll
    private let store: FilmStore
    
    init(store: FilmStore = ServiceLocator.shared.resolve()!) {
        self.store = store
    }
    
    func fetchFilms() {
        store.fetchFilms(category: selectedCategory, page: 1)
    }
}
