//
//  FilmStore.swift
//  otus_hw2
//
//  Created by Владимир Воротников on 30.12.2025.
//

import Foundation
import Combine
import KinopoiskAPI

final class FilmStore: ObservableObject {
    static let shared = FilmStore()
    @Published private(set) var films: [FilmCollectionResponseItems] = []
    @Published private(set) var page = 1
    
    private let filmsService: FilmsServiceProtocol
    private var finished = false
    private var canLoad = true
    
    init(filmsService: FilmsServiceProtocol = ServiceLocator.shared.resolve()!) {
        self.filmsService = filmsService
    }
    
    func fetchFilms(category: FilmsAPI.ModelType_apiV22FilmsCollectionsGet, page: Int = 1) {
        guard canLoad, !finished else { return }
        canLoad = false
        
        Task { @MainActor in
            do {
                let result = try await filmsService.fetchFilmsCollection(type: category, page: page)
                
                if page == 1 {
                    films.removeAll()
                    finished = false
                }
                
                self.page = page + 1
                finished = result.totalPages < self.page
                films.append(contentsOf: result.items)
                canLoad = true
            } catch {
                print("Ошибка загрузки: \(error)")
                canLoad = true
            }
        }
    }
}
