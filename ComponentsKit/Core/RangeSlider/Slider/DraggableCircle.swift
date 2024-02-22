//
//  DraggableCircle.swift
//  ComponentsKit
//
//  Created by Ульяна Гритчина on 22.02.2024.
//

import SwiftUI

struct DraggableCircle: View {
    var isLeft: Bool
    var limit: CGFloat
    @Binding var isDragging: Bool
    @Binding var position: CGFloat
    @Binding var otherPosition: CGFloat
    
    var body: some View {
        Circle()
            .frame(width: 20, height: 20)
            .foregroundStyle(.blue)
            .offset(x: position)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation {
                            isDragging = true
                        }
                        if isLeft {
                            position = min(max(value.location.x, 0 ), otherPosition)
                        } else {
                            position = min(max(value.location.x, otherPosition ), limit)
                        }
                    })
                    .onEnded({ value in
                        withAnimation {
                            isDragging = false
                        }
                    })
            )
    }
}
