//
//  RangeSliderView.swift
//  ComponentsKit
//
//  Created by Ульяна Гритчина on 22.02.2024.
//

import SwiftUI

struct RangeSliderView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    @FocusState private var isMinInputActive: Bool
    @FocusState private var isMaxInputActive: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                minValueTextField
                maxValueTextField
            }
            RangeSlider(
                minValue: $viewModel.minValue,
                maxValue: $viewModel.maxValue,
                range: viewModel.sliderRange
            )
        }
        .navigationTitle("Range Slider")
        .padding()
    }
}

#Preview {
    RangeSliderView()
}

extension RangeSliderView {
    
    private var minValueTextField: some View {
        TextField("min value", text: $viewModel.minValueString, onEditingChanged: { isEditing in
            viewModel.isTextFieldEditing = isEditing
        })
        .textFieldStyle(AppTextFieldStyle())
        .focused($isMinInputActive)
        .onChange(of: isMinInputActive, perform: { newValue in
            let newPrice = Int(viewModel.minValue)
            if newValue {
                viewModel.minValueString = newPrice.description
            } else {
                viewModel.setMinPriceText(price: newPrice)
            }
        })
        .onChange(of: viewModel.minValue, perform: { newValue in
            if !viewModel.isTextFieldEditing {
                viewModel.setMinPriceText(price: Int(newValue))
            }
        })
        .onChange(of: viewModel.minValueString) { _ in
            if viewModel.isTextFieldEditing {
                viewModel.setSliderValues()
            }
        }
    }
    
    private var maxValueTextField: some View {
        TextField("max value", text: $viewModel.maxValueString, onEditingChanged: { isEditing in
            viewModel.isTextFieldEditing = isEditing
        })
        .focused($isMaxInputActive)
        .textFieldStyle(AppTextFieldStyle())
        .onChange(of: isMaxInputActive, perform: { newValue in
            let newPrice = Int(viewModel.maxValue)
            if newValue {
                viewModel.maxValueString = newPrice.description
            } else {
                viewModel.setMinPriceText(price: newPrice)
            }
        })
        .onChange(of: viewModel.maxValue, perform: { newValue in
            if !viewModel.isTextFieldEditing {
                viewModel.setMaxPriceText(price: Int(newValue))
            }
        })
        .onChange(of: viewModel.maxValueString) { _ in
            if viewModel.isTextFieldEditing {
                viewModel.setSliderValues()
            }
        }
    }
    
}

public struct AppTextFieldStyle: TextFieldStyle {
    
    private let cornerRadius = 5.0
    
    public init() {}
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        let background = RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.gray.opacity(0.2))
        
        return configuration
            .padding(.top, 12)
            .padding(.bottom, 14)
            .padding(.horizontal, 7.77)
            .frame(height: 45)
            .font(.system(size: 16, weight: .regular))
            .background(background)
    }
    
}
