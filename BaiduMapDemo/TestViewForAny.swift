//
//  TestViewForAny.swift
//  BaiduMapDemo
//
//  Created by Kehong-IOS-Dev01 on 22/1/2024.
//

import Foundation
import SwiftUI


struct TestViewForAny: View {

        @State private var dragOffset = CGSize.zero
            @GestureState private var isLongPressing = false

            var body: some View {
                let longPressGesture = LongPressGesture(minimumDuration: 1)
                    .updating($isLongPressing) { currentState, gestureState, _ in
                        gestureState = currentState
                    }
                    .sequenced(before: DragGesture())

                let combinedGesture = longPressGesture.onChanged { value in
                    switch value {
                    case .second(true, let drag):
                        dragOffset = drag?.translation ?? .zero
                    default:
                        break
                    }
                }
                .onEnded { value in
                    switch value {
                    case .second(true, _):
                        dragOffset = .zero
                    default:
                        break
                    }
                }

                return Circle()
                    .fill(isLongPressing ? Color.green : Color.blue)
                    .frame(width: 100, height: 100)
                    .offset(dragOffset)
                    .gesture(combinedGesture)
            }
    
}
