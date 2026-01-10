//
//  SceletonView.swift
//  otus_hw2
//
//  by Владимир Воротников on 30.12.2025.
//

import Foundation
import SwiftUI

struct SkeletonView: View {
    var width: CGFloat
    var height: CGFloat
    
    @State private var isAnimating = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color.cyan.opacity(0.9), Color.cyan.opacity(0.1), Color.cyan.opacity(0.9)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: width, height: height)
            .shimmerEffect()
    }
}

extension View {
    func shimmerEffect() -> some View {
        self.modifier(ShimmerEffect())
    }
}

struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = -1
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1), Color.gray.opacity(0.3)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .mask(content)
                .offset(x: phase * 200)
                .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false), value: phase)
            )
            .onAppear {
                phase = 1
            }
    }
}
