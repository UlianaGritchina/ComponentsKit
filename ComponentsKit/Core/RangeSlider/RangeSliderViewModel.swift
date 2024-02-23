//
//  RangeSliderViewModel.swift
//  ComponentsKit
//
//  Created by Ульяна Гритчина on 22.02.2024.
//

import Foundation

extension RangeSliderView {
    @MainActor final class ViewModel: ObservableObject {
    
        // MARK: Constants
        
        let sliderRange = 0...100_000
        
        // MARK: Published
        
        @Published var minValue: Double
        @Published var maxValue: Double
        @Published var minValueString = ""
        @Published var maxValueString = ""
        @Published var isTextFieldEditing = false
        
        init() {
            minValue = Double(sliderRange.lowerBound)
            maxValue = Double(sliderRange.upperBound)
            setSliderValues()
            setMinPriceText(price: Int(minValue))
            setMaxPriceText(price: Int(maxValue))
        }
        
        // MARK: Public Methods
        
        func setMinPriceText(price: Int) {
            let formatPrice = priceFormate(number: price)
            minValueString = "\(formatPrice) €"
        }
        
        func setMaxPriceText(price: Int) {
            let formatPrice = priceFormate(number: price)
            maxValueString = "\(formatPrice) €"
        }
        
        func priceFormate(number: Int) -> String {
            let newNumber = Float(number)
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = " "
            return formatter.string(from: NSNumber(value: newNumber)) ?? ""
        }
        
        func setSliderValues() {
            let upperBound = Double(sliderRange.upperBound)
            let lowerBound = Double(sliderRange.lowerBound)
            
            if let min = Double(minValueString) {
                if min <= maxValue && min >= lowerBound {
                    minValue = min
                } else {
                    minValue = maxValue
                }
            }
            if let max = Double(maxValueString) {
                if max >= minValue && max <= upperBound {
                    maxValue = max
                } else if max > upperBound {
                    maxValue = upperBound
                } else {
                    maxValue = minValue
                }
            }
        }
    }
}
