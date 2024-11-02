//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Services
import SwiftUI

struct SettingsTab: View {
  @Environment(UserPreferences.self) private var userPreferences
  @State private var showingFDCInfo = false

  var body: some View {
    NavigationStack {
      Form {
        kTargetSection
        aboutSection
      }
      .navigationTitle("settings.title")
      .sheet(
        isPresented: $showingFDCInfo,
        content: {
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
          Text("\(String(format: "%.0f", userPreferences.kTarget)) µg ")
        }
      }
    }
  }

  private var aboutSection: some View {
    Section("settings.about") {
      Button(
        action: {
          showingFDCInfo.toggle()
        },
        label: {
          Label(
            "settings.about.fdc", systemImage: "fork.knife")
        })
      HStack {
        NavigationLink {
          AboutView()
        } label: {
          Label("settings.about.kfinder", systemImage: "chevron.left.to.line")
          Spacer()
          Text("v\(UIApplication.version)")
        }
      }
    }
  }
}

#Preview {
  SettingsTab()
    .environment(UserPreferences.shared)
}
