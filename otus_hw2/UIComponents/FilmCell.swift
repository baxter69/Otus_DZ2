//
//  FilmCell.swift
//  otus_hw2
//
//  Created by Владимир Воротников on 30.12.2025.
//

import Foundation
import SwiftUI
import KinopoiskAPI

struct FilmCell: View {
    let film: FilmCollectionResponseItems
    let isFlying: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.gray)
                
                VStack {
                    AsyncImage(url: URL(string: film.posterUrlPreview ?? "")) { image in
                        image.resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .shadow(color: .cyan, radius: 10)
                    } placeholder: {
                        SkeletonView(width: 250, height: 350)
                    }
                    .padding()
                    
                    Text(film.nameRu ?? "No name")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 500)
            .offset(x: isFlying ? 50 : 0, y: isFlying ? 200 : 0)
            .scaleEffect(isFlying ? 0.5 : 1)
            .opacity(isFlying ? 0 : 1)
            .rotationEffect(.degrees(isFlying ? 20 : 0))
            .animation(.easeOut(duration: 0.6), value: isFlying)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

