//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct VitaminKTargetView: View {
  @AppStorage(StorageKeys.kTarget.rawValue) private var kTarget = 120
  
  var body: some View {
    HStack {
      Label("Vitamin K Target", systemImage: "target")
      Spacer()
      Text("\(kTarget) µg")
    }
  }
}

struct VitaminKTargetView_Previews: PreviewProvider {
  static var previews: some View {
    VitaminKTargetView()
  }
}
