//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Services
import SwiftUI

struct SettingsView: View {
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.dismiss) private var dismiss
  @Environment(UserPreferences.self) private var userPreferences
  @State private var showingKTarget = false
  @State private var showingFDCInfo = false
  @State private var showingAboutInfo = false

  var body: some View {
    HStack {
      Text("settings.title")
        .font(.title)
        .fontWeight(.bold)
        .padding()
      Spacer()
      Button(
        action: {
          dismiss()
        },
        label: {
          Image(systemName: "xmark")
            .font(.title)
            .padding()
        }
      )
      .tint(colorScheme == .light ? .black : .white)
    }
    VStack {
      Form {
        kTargetSection
        aboutSection
      }
      .sheet(isPresented: $showingKTarget) {
        VitaminKTargetView()
          .presentationDetents([.fraction(0.75)])
      }
      .sheet(isPresented: $showingFDCInfo) {
        InfoPageView(
          info: "settings.fdc.info", footnote: "settings.fdc.footnote"
        )
        .presentationDetents([.fraction(0.45)])
      }
      .sheet(isPresented: $showingAboutInfo) {
        AboutView()
      }
    }
  }

  private var kTargetSection: some View {
    Section("settings.tracking") {
      Button(
        action: {
          showingKTarget.toggle()
        },
        label: {
          HStack {
            Label("settings.ktarget", systemImage: "target")
            Spacer()
            Text("\(String(format: "%.0f", userPreferences.dailyKTarget)) µg ")
          }
        })
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
        Button(
          action: {
            showingAboutInfo.toggle()
          },
          label: {
            HStack {
              Label(
                "settings.about.kfinder", systemImage: "chevron.left.to.line")
              Text("v\(UIApplication.version)")
            }
          }
        )
      }
    }
  }
}

#Preview {
  SettingsView()
    .environment(UserPreferences.shared)
}
