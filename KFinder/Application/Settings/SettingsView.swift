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
    VStack {
      HStack {
        Text("settings.title")
          .font(.title)
          .fontWeight(.bold)
          .padding()
        Spacer()
        Button {
          dismiss()
        } label: {
          Image(systemName: "xmark")
            .font(.title)
            .padding()
        }
      }
      VStack {
        Form {
          kTargetSection
          testingSection
          aboutSection
        }
        .sheet(isPresented: $showingKTarget) {
          VitaminKTargetView()
            .presentationDetents([.fraction(0.75)])
        }
        .popUp(isPresented: $showingFDCInfo) {
          InfoPageView(
            info: "settings.fdc.info", footnote: "settings.fdc.footnote"
          )
          .padding(.horizontal)
        }
        .popUp(isPresented: $showingAboutInfo) {
          AboutView()
            .padding(.horizontal)
        }
      }
    }
  }

  @ViewBuilder
  private var kTargetSection: some View {
    @Bindable var userPrefs = userPreferences

    Section("settings.tracking") {
      Button {
        showingKTarget.toggle()
      } label: {
        HStack {
          Label("settings.ktarget", systemImage: "target")
          Spacer()
          Text("\(String(format: "%.0f", userPreferences.dailyKTarget)) µg ")
        }
      }
      Stepper(value: $userPrefs.recentFoodsLimit, in: 3...10) {
        HStack {
          Label("settings.recent.foods.limit", systemImage: "carrot")
          Spacer()
          Text("\(userPrefs.recentFoodsLimit) ")
        }
      }
    }
  }

  @ViewBuilder
  private var testingSection: some View {
    @Bindable var userPrefs = userPreferences

    Section("settings.testing") {
      Toggle(isOn: $userPrefs.setProTimeReminders) {
        Label("settings.testing.enabled", systemImage: "alarm")
      }
      Stepper(value: $userPrefs.defaultProTimeInterval, in: 2...6) {
        HStack {
          Label(
            "settings.testing.interval.default", systemImage: "calendar")
          Spacer()
          Text("\(userPrefs.defaultProTimeInterval) ")
        }
      }
    }
  }

  private var aboutSection: some View {
    Section("settings.about") {
      Button {
        showingFDCInfo.toggle()
      } label: {
        Label(
          "settings.about.fdc", systemImage: "fork.knife"
        )
      }
      HStack {
        Button {
          showingAboutInfo.toggle()
        } label: {
          HStack {
            Label(
              "settings.about.kfinder", systemImage: "apps.iphone"
            )
            Spacer()
            Text("v\(UIApplication.version)")
          }
        }
      }
    }
  }
}

#if DEBUG
#Preview {
  SettingsView()
    .environment(UserPreferences.shared)
}
#endif
