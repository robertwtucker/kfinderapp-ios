//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Services
import SwiftUI

struct VitaminKTargetView: View {
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.dismiss) private var dismiss
  @Environment(UserPreferences.self) private var userPreferences

  @State private var showingVitaminKInfo = false
  @FocusState private var focusedField: Field?

  enum Field: Hashable {
    case target
  }

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
        valueSection
        InfoPageView(
          info: "settings.ktarget.info", footnote: "settings.ktarget.footnote"
        )
        .listRowBackground(Color.appBaseBackground(for: colorScheme))
      }
      Button {
        dismiss()
      } label: {
        Text("button.dismiss")
      }
    }
    .defaultFocus($focusedField, .target)
  }

  @ViewBuilder
  private var valueSection: some View {
    @Bindable var userPrefs = userPreferences

    Section(header: Text("settings.ktarget.measure")) {
      TextField(
        "settings.ktarget.value", value: $userPrefs.dailyKTarget,
        format: .number
      )
      .multilineTextAlignment(.trailing)
      .keyboardType(.numbersAndPunctuation)
      .focused($focusedField, equals: .target)
    }
  }
}

#if DEBUG
#Preview {
  VitaminKTargetView()
    .environment(UserPreferences.shared)
}
#endif
