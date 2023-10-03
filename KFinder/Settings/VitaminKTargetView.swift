//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct VitaminKTargetView: View {
  enum Field: Hashable {
    case target
  }
  
  @AppStorage(StorageKeys.kTarget.rawValue) private var kTarget: Double = 120
  @State private var showingVitaminKInfo = false
  @FocusState private var focusedField: Field?
  
  var body: some View {
    Form {
      valueSection
      infoSection
      .defaultFocus($focusedField, .target)
    }
    .navigationTitle("settings.ktarget.title")
  }
  
  private var valueSection: some View {
    Section(header: Text("settings.ktarget.measure")) {
      TextField("settings.ktarget.value", value: $kTarget, format: .number)
        .multilineTextAlignment(.trailing)
        .keyboardType(.numbersAndPunctuation)
        .focused($focusedField, equals: .target)
    }
  }
  
  private var infoSection: some View {
    let info: LocalizedStringKey = "settings.ktarget.info"
    let footnote: LocalizedStringKey = "settings.ktarget.footnote"
    
    return Section {
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

#Preview {
  VitaminKTargetView()
}
