//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct SettingsView: View {
  @State private var showingFDCInfo = false
  
  var body: some View {
    NavigationStack {
      List {
        Section {
          NavigationLink {
            VitaminKTargetDetailView()
          } label: {
            VitaminKTargetView()
          }
        }
        Section("About") {
          Button(action: {
            showingFDCInfo.toggle()
          }, label: {
            Label("FoodData Central", systemImage: "square.3.layers.3d.top.filled")
          })
          HStack {
            Label("KFinder", systemImage: "number.square")
            Spacer()
            Text("v\(UIApplication.version)")
          }
        }
      }
      .navigationTitle("Settings")
      .sheet(isPresented: $showingFDCInfo, content: {
        let info: LocalizedStringKey = "The foods and nutritional values used in KFinder are provided by the U.S. Department of Agriculture (USDA). The USDA makes its food composition data available via [FoodData Central](https://fdc.nal.usda.gov)."
        let footnote: LocalizedStringKey = "Source: U.S. Department of Agriculture, Agricultural Research Service. FoodData Central, 2019. [fdc.nal.usda.gov](https://fdc.nal.usda.gov)."
        
        InfoPageView(info: info, footnote: footnote)
          .presentationDetents([.fraction(0.40)])
          .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
      })
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
