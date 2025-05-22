//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Defaults
import Services
import SwiftUI

struct VitaminKTargetView: View {
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    VStack {
      Form {
        HStack {
          Spacer()
          Text("settings.ktarget.title")
            .font(.title2).bold()
            .padding(.top, 8)
          Spacer()
        }
        .listRowBackground(Color.appBaseBackground(for: colorScheme))
        TargetSection()
        InfoPageView(
          info: "settings.ktarget.info",
          footnote: "settings.ktarget.footnote"
        )
        .listRowBackground(Color.appBaseBackground(for: colorScheme))
      }
      Button {
        dismiss()
      } label: {
        Text("button.dismiss")
      }
    }
  }

  private struct TargetSection: View {
    @Default(.dailyKTarget) private var dailyKTarget
    @FocusState private var isTargetFieldFocused: Bool

    var body: some View {
      Section(header: Text("settings.ktarget.measure")) {
        TextField(
          "settings.ktarget.value",
          value: $dailyKTarget,
          format: .number
        )
        .focused($isTargetFieldFocused)
        .multilineTextAlignment(.trailing)
        .keyboardType(.numbersAndPunctuation)
      }
    }
  }
}

#if DEBUG
  #Preview {
    VitaminKTargetView()
  }
#endif
