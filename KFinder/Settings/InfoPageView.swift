//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct InfoPageView: View {
  @Environment(\.dismiss) private var dismiss
  let info: LocalizedStringKey
  let footnote: LocalizedStringKey
  
    var body: some View {
      VStack {
        VStack(alignment: .leading, spacing: 16) {
          Text(info)
          Text(footnote).font(.footnote)
        }
        Spacer()
        Button(action: {
          dismiss()
        }, label: {
          Text("Dismiss")
        })
      }
    }
}

#Preview {
  InfoPageView(info: "info", footnote: "footnote")
}
