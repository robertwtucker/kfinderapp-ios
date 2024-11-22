//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import DesignSystem
import SwiftUI

struct ErrorAlert: Identifiable {
  var id = UUID()
  var message: String
  var dismissAction: (() -> Void)?
}

@MainActor
@Observable class ErrorHandling {
  var currentAlert: ErrorAlert?

  func handle(error: Error) {
    currentAlert = ErrorAlert(message: error.localizedDescription)
  }
}

struct HandleErrorsWithAlertViewModifier: ViewModifier {
  @State var errorHandling = ErrorHandling()

  func body(content: Content) -> some View {
    content
      .environment(errorHandling)
      .background(
        EmptyView()
          .alert(item: $errorHandling.currentAlert) { currentAlert in
            Alert(
              title: Text("alert.title"),
              message: Text(currentAlert.message),
              dismissButton: .default(Text("alert.dismiss")) {
                currentAlert.dismissAction?()
              }
            )
          }
      )
  }
}

extension View {
  func withErrorHandling() -> some View {
    modifier(HandleErrorsWithAlertViewModifier())
  }
}
