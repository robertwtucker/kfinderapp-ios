//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct VitaminKTargetView: View {
  @AppStorage("kTarget") var kTarget = "120"
  @State private var showingVitaminKInfo = false
  
  var body: some View {
    HStack {
      Group {
        Label("Vitamin K Target", systemImage: "target")
        Button {
          showingVitaminKInfo.toggle()
        } label: {
          Image(systemName: "info.circle")
        }
      }
      Spacer()
      Group {
        TextField("", text: $kTarget)
          .multilineTextAlignment(.trailing)
          .frame(width: 64)
          .keyboardType(.numberPad)
          .onChange(of: kTarget, initial: false) { _, newValue  in
            kTarget = allowNumbers(newValue)
          }
        Text("µg")
      }
    }
    .sheet(isPresented: $showingVitaminKInfo) {
      let info: LocalizedStringKey = "The U.S. Food and Drug Administration (FDA) has established a recommended Daily Value of 120 µg (micrograms) for adults and children over 4 years of age."
      let footnote: LocalizedStringKey = "See: [Food Labeling: Revision of the Nutrition and Supplement Facts Labels](https://www.federalregister.gov/documents/2016/05/27/2016-11867/food-labeling-revision-of-the-nutrition-and-supplement-facts-labels)"
      
      InfoPageView(info: info, footnote: footnote)
        .presentationDetents([.fraction(0.30)])
        .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
    }
  }
  
  func allowNumbers(_ inputValue: String) -> String {
    return inputValue.filter { "0123456789".contains($0) }
  }
  
}

struct VitaminKTargetView_Previews: PreviewProvider {
  static var previews: some View {
    VitaminKTargetView()
  }
}
