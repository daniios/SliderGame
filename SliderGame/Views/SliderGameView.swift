//
//  SliderGameView.swift
//  SliderGame
//
//  Created by Даниил Чупин on 30.07.2023.
//

import SwiftUI

struct SliderGameView: View {
    @State private var targetValue: Int = Int.random(in: 0...100)
    @State private var currentValue: Double = 50.0
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Подвинь слайдер, как можно ближе к: \(targetValue)")
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.bottom, 20)
            
            HStack {
                Text("0")
                SliderUIKit(value: $currentValue, targetValue: $targetValue)
                Text("100")
            }
            
            Button("Проверь меня") {
                showAlert.toggle()
            }
            .alert(isPresented: $showAlert) {
                let difference = abs(targetValue - lround(currentValue))
                let score = 100 - difference
                
                return Alert(
                    title: Text("Результат"),
                    message: Text("Вы получили \(score) баллов"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .padding(.vertical)
            
            Button("Начать заново") {
                resetGame()
            }
        }
        .padding()
    }

    private func resetGame() {
        targetValue = Int.random(in: 0...100)
        currentValue = Double.random(in: 0...100)
    }
}

