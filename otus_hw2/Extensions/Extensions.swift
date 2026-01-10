//
//  Extensions.swift
//  otus_hw2
//
//  Created by Владимир Воротников on 30.12.2025.
//

import Foundation
import KinopoiskAPI
import SwiftUI

extension FilmCollectionResponseItems: @retroactive Identifiable
{
    public var id: Int { kinopoiskId }
}

extension FilmsAPI.ModelType_apiV22FilmsCollectionsGet {
    var displayName: String {
        switch self {
        case .topPopularAll: return "Популярные"
        case .top250Movies: return "Популярные фильмы"
        case .top250TvShows: return "Популярные сериалы"
        default: return "Другое"
        }
    }
}
extension View {
    func showActivity(isLoading: Bool) -> some View {
        modifier(ItemModifier(isLoading: isLoading))
    }
}
extension RandomAccessCollection where Self.Element: Identifiable {
    func needToLoad<Item: Identifiable>(item: Item) -> Bool {
        guard isEmpty == false else { return false }
        guard let itemIndex = firstIndex(where: { AnyHashable(item.id) == AnyHashable($0.id) }) else {
            return false
        }
        let distance = self.distance(from: itemIndex, to: endIndex)
        return distance == 4
    }
}
