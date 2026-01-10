//
//  ItemModifier.swift
//  otus_hw2
//
//  Created by Владимир Воротников on 30.12.20255.
//

import Foundation
import SwiftUI

struct ItemModifier: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        if isLoading {
            VStack {
                content
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        } else {
            content
        }
    }
}
