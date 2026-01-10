//
//  FilmListViewModel.swift
//  otus_hw2
//
//  by Владимир Воротников on 30.12.2025.
//

import Foundation
import Combine
import KinopoiskAPI


final class FilmListViewModel: ObservableObject {
    @Published var films: [FilmCollectionResponseItems] = []
    @Published var page = 1
    
    private let store: FilmStore
    private let mediator: FilmMediator
    
    private var cancellables = Set<AnyCancellable>()
    
    init(store: FilmStore = ServiceLocator.shared.resolve()!,
         mediator: FilmMediator = FilmMediator.shared) {
        self.store = store
        self.mediator = mediator
        
        store.$films
            .receive(on: DispatchQueue.main)
            .assign(to: &$films)
        
        store.$page
            .receive(on: DispatchQueue.main)
            .assign(to: &$page)
        
        mediator.$selectedCategory
            .sink { [weak self] category in
                self?.fetch(category: category)
            }
            .store(in: &cancellables)
    }
    
    func fetch(category: FilmsAPI.ModelType_apiV22FilmsCollectionsGet, page: Int = 1) {
        store.fetchFilms(category: category, page: page)
    }
}
