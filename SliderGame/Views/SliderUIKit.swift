//
//  SliderUIKit.swift
//  SliderGame
//
//  Created by Даниил Чупин on 30.07.2023.
//

import SwiftUI
import UIKit

struct SliderUIKit: UIViewRepresentable {
    @Binding var value: Double
    @Binding var targetValue: Int

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = Float(value)
        
        slider.addTarget(context.coordinator,
                         action: #selector(Coordinator.valueChanged(_:)),
                         for: .valueChanged)
        
        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
        updateAlpha(uiView)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    private func updateAlpha(_ uiSlider: UISlider) {
        let difference = abs(value - Double(targetValue))
        let alpha = 1.0 - difference / 100.0
        uiSlider.thumbTintColor = UIColor(Color.green.opacity(alpha))
    }

    final class Coordinator: NSObject {
        var sliderUIKit: SliderUIKit

        init(_ sliderUIKit: SliderUIKit) {
            self.sliderUIKit = sliderUIKit
        }

        @objc func valueChanged(_ sender: UISlider) {
            sliderUIKit.value = Double(sender.value)
            sliderUIKit.updateAlpha(sender)
        }
    }
}
