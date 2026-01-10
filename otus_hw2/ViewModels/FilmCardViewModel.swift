//
//  FilmCardViewModel.swift
//  otus_hw2
//
//  by Владимир Воротников on 30.12.2025.
//

import Foundation
import SwiftUI
import KinopoiskAPI

final class FilmCardViewModel: ObservableObject {
    @Published var filmDetails: Film?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let filmsService: FilmsServiceProtocol
    
    init(filmsService: FilmsServiceProtocol = ServiceLocator.shared.resolve()!) {
        self.filmsService = filmsService
    }
    
    func fetchFilmDetails(filmId: Int) {
        Task { @MainActor in
            isLoading = true
            errorMessage = nil
            
            do {
                self.filmDetails = try await filmsService.fetchFilmDetails(id: filmId)
            } catch {
                self.errorMessage = "Ошибка загрузки: \(error.localizedDescription)"
            }
            
            isLoading = false
        }
    }
}
