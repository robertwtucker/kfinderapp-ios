//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct VitaminKTargetDetailView: View {
  enum Field: Hashable {
    case target
  }
  
  @AppStorage(StorageKeys.kTarget.rawValue) private var kTarget: Double = 120
  @State private var showingVitaminKInfo = false
  @FocusState private var focusedField: Field?
  
  var body: some View {
    Form {
      Section(header: Text("settings.ktarget.measure")) {
        TextField("settings.ktarget.value", value: $kTarget, format: .number)
          .multilineTextAlignment(.trailing)
          .keyboardType(.numbersAndPunctuation)
          .focused($focusedField, equals: .target)
      }
      Section {
        VStack(spacing: 16) {
          Label("", systemImage: "info.circle.fill")
            .font(.title)
            .fontWeight(.bold)
          VStack(alignment: .leading, spacing: 32) {
            Text(info)
            Text(footnote)
              .font(.footnote)
          }
        }
      }
      .defaultFocus($focusedField, .target)
    }
    .navigationTitle("settings.ktarget.title")
  }
  
  let info: LocalizedStringKey = "settings.ktarget.info"
  let footnote: LocalizedStringKey = "settings.ktarget.footnote"
}

#Preview {
  VitaminKTargetDetailView()
}
