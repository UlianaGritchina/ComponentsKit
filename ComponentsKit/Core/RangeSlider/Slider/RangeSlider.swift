//
//  RangeSliderView.swift
//  ComponentsKit
//
//  Created by Ульяна Гритчина on 22.02.2024.
//

import Foundation

import SwiftUI

public struct RangeSlider: View {
    
    @Binding var min: Double
    @Binding var max: Double
    
    @State private var width: CGFloat = 0
    @State private var widthTwo: CGFloat = 15
    @State var isDraggingLeft = false
    @State var isDraggingRight = false
    @State var totalScreen: CGFloat = 0
    
    let offsetValue: CGFloat = 30
    let maxValue: CGFloat = 70_000
    
    public init(minValue: Binding<Double>, maxValue: Binding<Double>) {
        _min = minValue
        _max = maxValue
    }
    
    var lowerValue: Int {
        Int(map(value: width, from: 0...totalScreen, to: 0...maxValue))
    }
    
    var upperValue: Int {
        Int(map(value: widthTwo, from: 0...totalScreen, to: 0...maxValue))
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray)
                    .opacity (0.3)
                    .frame(height: 3)
                    .padding(.horizontal, 6)
                    .frame(height: 2)
                
                Rectangle()
                    .frame(height: 3)
                    .foregroundStyle(.blue)
                    .frame(width: widthTwo - width + 25, height: 2)
                    .offset(x: width)
                
                HStack(spacing: 0) {
                    DraggableCircle(
                        isLeft: true,
                        limit: totalScreen,
                        isDragging:$isDraggingLeft,
                        position: $width,
                        otherPosition: $widthTwo
                    )
                    DraggableCircle(
                        isLeft: false,
                        limit: totalScreen,
                        isDragging: $isDraggingRight,
                        position: $widthTwo,
                        otherPosition:  $width
                    )
                }
            }
            .onChange(of: upperValue, perform: { value in
                max = Double(value)
            })
            .onChange(of: lowerValue, perform: { value in
                min = Double(value)
            })
            .frame(width: geometry.size.width, height: 20)
            .onAppear {
                totalScreen = geometry.size.width - offsetValue
                widthTwo = totalScreen
                setMinHandle(min)
                setMaxHandle(max)
            }
            .onChange(of: min) { newValue in setMinHandle(newValue) }
            .onChange(of: max) { newValue in setMaxHandle(newValue) }
        }
    }
    
    private func setMinHandle(_ value: Double) {
        width = CGFloat(value) * totalScreen / maxValue
    }
    
    private func setMaxHandle(_ value: Double ) {
        widthTwo = CGFloat(value) * totalScreen / maxValue
    }
    
    func map(value: CGFloat, from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let inputRange = from.upperBound - from.lowerBound
        guard inputRange != 0 else { return 0 }
        let outputRange = to.upperBound - to.lowerBound
        return (value - from.lowerBound) / inputRange * outputRange + to.lowerBound
    }
    
}

#Preview {
    RangeSlider(minValue: .constant(0), maxValue: .constant(70000))
}

