//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct SettingsView: View {
  @Environment(UserPreferences.self) private var userPreferences
  @Binding var showSettings: Bool
  @State private var showingFDCInfo = false
  
  var body: some View {
    NavigationStack {
      Form {
        kTargetSection
        aboutSection
        dismissButton
      }
      .navigationTitle("settings.title")
      .sheet(isPresented: $showingFDCInfo, content: {
        let info: LocalizedStringKey = "settings.fdc.info"
        let footnote: LocalizedStringKey = "settings.fdc.footnote"
        
        InfoPageView(info: info, footnote: footnote)
          .presentationDetents([.fraction(0.40)])
          .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
      })
    }
  }
  
  private var kTargetSection: some View {
    Section("settings.tracking") {
      NavigationLink {
        VitaminKTargetView()
      } label: {
        HStack {
          Label("settings.ktarget", systemImage: "target")
          Spacer()
          Text("\(String(format: "%.0f", userPreferences.kTarget)) µg")
        }
      }
    }
  }
  
  private var aboutSection: some View {
    Section("settings.about") {
      Button(action: {
        showingFDCInfo.toggle()
      }, label: {
        Label("settings.about.fdc", systemImage: "square.3.layers.3d.top.filled")
      })
      HStack {
        Label("settings.about.kfinder", systemImage: "number.square")
        Spacer()
        Text("v\(UIApplication.version)")
      }
    }
  }
  
  private var dismissButton: some View {
    Section {
      Button(action: {
        showSettings.toggle()
      }, label: {
        HStack {
          Spacer()
          Text("button.dismiss")
          Spacer()
        }
      })
    }
  }
}

#Preview {
  SettingsView(showSettings: .constant(true))
    .environment(UserPreferences.shared)
}
