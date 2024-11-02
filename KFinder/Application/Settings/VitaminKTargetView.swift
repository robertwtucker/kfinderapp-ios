//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Services
import SwiftUI

struct VitaminKTargetView: View {
  @Environment(UserPreferences.self) private var userPreferences
  @State private var showingVitaminKInfo = false
  @FocusState private var focusedField: Field?

  enum Field: Hashable {
    case target
  }

  var body: some View {
    Form {
      valueSection
      infoSection
    }
    .defaultFocus($focusedField, .target)
    .navigationTitle("settings.ktarget.title")
  }

  @ViewBuilder
  private var valueSection: some View {
    @Bindable var userPrefs = userPreferences
    
    Section(header: Text("settings.ktarget.measure")) {
      TextField(
        "settings.ktarget.value", value: $userPrefs.kTarget, format: .number
      )
      .multilineTextAlignment(.trailing)
      .keyboardType(.numbersAndPunctuation)
      .focused($focusedField, equals: .target)
    }
  }

  @ViewBuilder
  private var infoSection: some View {
    let info: LocalizedStringKey = "settings.ktarget.info"
    let footnote: LocalizedStringKey = "settings.ktarget.footnote"

    Section {
      VStack(spacing: 16) {
        Label("settings.ktarget", systemImage: "info.circle.fill")
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(.accentColor)
          .labelStyle(.iconOnly)
        VStack(alignment: .leading, spacing: 32) {
          Text(info)
          Text(footnote)
            .font(.footnote)
        }
      }
    }
  }
}
