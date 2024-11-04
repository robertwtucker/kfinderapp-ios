//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct LoadingView: View {
  var body: some View {
    VStack {
      ProgressView()
      Spacer()
    }
    .padding()
  }
}

struct SimpleLoadingView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView()
  }
}
