//
//  FilmDescriptionView.swift
//  otus_hw2
//
//  Created by Владимир Воротников on 30.12.2025.
//

import SwiftUI
import KinopoiskAPI

struct FilmDescriptionView: View {
    let film: Film
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Основной прокручиваемый контент
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(film.nameRu ?? film.nameOriginal ?? "Без названия")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 10)
                    
                    Text(film.description ?? "Описание отсутствует")
                        .font(.body)
                }
                .padding()
                .padding(.top, 70)
            }
            .background(Color.white)
            .ignoresSafeArea()
            
            // Кнопка "Закрыть" внизу
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Закрыть")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom, 10)
        }
    }
}
