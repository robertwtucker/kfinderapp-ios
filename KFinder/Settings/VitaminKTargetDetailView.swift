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
      Section(header: Text("Vitamin K (micrograms)")) {
        TextField("Value", value: $kTarget, format: .number)
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
    .navigationTitle("Daily Target")
  }
  
  let info: LocalizedStringKey = "The U.S. Food and Drug Administration (FDA) has established a recommended Daily Value of 120 micrograms (µg or mcg) for adults and children over 4 years of age."
  let footnote: LocalizedStringKey = "See: [Food Labeling: Revision of the Nutrition and Supplement Facts Labels](https://www.federalregister.gov/documents/2016/05/27/2016-11867/food-labeling-revision-of-the-nutrition-and-supplement-facts-labels)"
}

#Preview {
  VitaminKTargetDetailView()
}
