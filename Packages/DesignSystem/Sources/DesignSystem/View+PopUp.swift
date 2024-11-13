//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Robert Tucker on 11/13/24.
//

import SwiftUI

extension View {
  public func popUp<V>(
    isPresented: Binding<Bool>,
    @ViewBuilder content: @escaping () -> V
  ) -> some View where V: View {
    self
      .blur(radius: isPresented.wrappedValue ? 4 : 0.0)
      .overlay {
        if isPresented.wrappedValue {
          ZStack {
            Color(Color.appDarkGray)
              .edgesIgnoringSafeArea(.all)
              .opacity(0.8)
              .onTapGesture {
                isPresented.wrappedValue = false
              }
            VStack {
              Spacer()
              content()
              Spacer()
            }
          }
          .frame(height: UIScreen.main.bounds.height)
        }
      }
  }
}
