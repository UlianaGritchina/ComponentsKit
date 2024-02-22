//
//  RangeSliderViewModel.swift
//  ComponentsKit
//
//  Created by Ульяна Гритчина on 22.02.2024.
//

import Foundation

extension RangeSliderView {
    @MainActor final class ViewModel: ObservableObject {
        
        // MARK: Published
        
        @Published var minValue: Double = 0
        @Published var maxValue: Double = 10_000
        @Published var minValueString = ""
        @Published var maxValueString = ""
        @Published var isTextFieldEditing = false
        
        init() {
            setSliderValues()
            setMinPriceText(price: Int(minValue))
            setMaxPriceText(price: Int(maxValue))
        }
        
        // MARK: Public Methods
        
        func setMinPriceText(price: Int) {
            let formatPrice = priceFormate(number: price)
            minValueString = "\(formatPrice) ₽"
        }
        
        func setMaxPriceText(price: Int) {
            let formatPrice = priceFormate(number: price)
            maxValueString = "\(formatPrice) ₽"
        }
        
        func priceFormate(number: Int) -> String {
            let newNumber = Float(number)
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = " "
            return formatter.string(from: NSNumber(value: newNumber)) ?? ""
        }
        
        func setSliderValues() {
            if let min = Double(minValueString) {
                if min <= maxValue && min >= 0 {
                    minValue = min
                } else {
                    minValue = maxValue
                }
            }
            if let max = Double(maxValueString) {
                if max >= minValue && max <= 70_000 {
                    maxValue = max
                } else if max > 70_000 {
                    maxValue = 70_000
                } else {
                    maxValue = minValue
                }
            }
        }
    }
}
