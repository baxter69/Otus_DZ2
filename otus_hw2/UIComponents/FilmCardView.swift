//
//  FilmCardView.swift
//  otus_hw2
//
//  Created by Владимир Воротников on 30.12.2025.
//

import SwiftUI

struct FilmCardView: View {
    @StateObject var viewModel = FilmCardViewModel()
    let filmId: Int
    @State private var isDescriptionPresented = false
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Загрузка...")
            } else if let film = viewModel.filmDetails {
                ScrollView {
                    VStack {
                        AsyncImage(url: URL(string: film.posterUrl)) { image in
                            image.resizable()
                                .scaledToFit()
                                .cornerRadius(20)
                                .shadow(radius: 10)
                        } placeholder: {
                            SkeletonView(width: 300, height: 450)
                        }
                        .frame(width: 300, height: 450)
                        
                        HStack {
                            HStack {
                                Text("Год:")
                                    .bold()
                                Text(String(format: "%d", film.year ?? 0))
                            }
                            .padding(.top, 5)
                            
                            HStack {
                                Text("Рейтинг:")
                                    .bold()
                                Text("\(film.ratingKinopoisk ?? 0.0, specifier: "%.1f")")
                            }
                            .padding(.top, 5)
                        }
                        Button(action: {
                            isDescriptionPresented = true
                        }) {
                            Text("Описание")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                }
                .navigationTitle(film.nameRu ?? film.nameOriginal ?? "Без названия")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchFilmDetails(filmId: filmId)
        }
        .fullScreenCover(isPresented: $isDescriptionPresented) {
            FilmDescriptionView(film: viewModel.filmDetails!)
        }
    }
}
