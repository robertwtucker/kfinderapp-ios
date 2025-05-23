//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Defaults
import Services
import SwiftUI

struct SettingsView: View {
  @Environment(\.colorScheme) private var colorScheme

  @State private var showingKTarget = false
  @State private var showingFDCInfo = false
  @State private var showingAboutInfo = false

  var body: some View {
    VStack {
      SettingsHeader()
      Form {
        Section("settings.tracking") {
          TrackingSettings(showingKTarget: $showingKTarget)
        }
        Section("settings.testing") {
          TestingSettings()
        }
        Section("settings.about") {
          AboutSettings(
            showingFDCInfo: $showingFDCInfo,
            showingAboutInfo: $showingAboutInfo
          )
        }
      }
      .sheet(isPresented: $showingKTarget) {
        VitaminKTargetView()
          .presentationDetents([.fraction(0.75)])
      }
      .popUp(isPresented: $showingFDCInfo) {
        InfoPageView(
          info: "settings.fdc.info",
          footnote: "settings.fdc.footnote"
        )
        .padding(.horizontal)
      }
      .popUp(isPresented: $showingAboutInfo) {
        AboutView()
          .padding(.horizontal)
      }
    }
  }

  private struct SettingsHeader: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
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
    }
  }

  private struct TrackingSettings: View {
    private let minimumFoodCount = 3
    private let maximumFoodCount = 10

    @Binding var showingKTarget: Bool
    @Default(.dailyKTarget) private var dailyKTarget
    @Default(.recentFoodsLimit) private var recentFoodsLimit

    var body: some View {
      Group {
        Button {
          showingKTarget.toggle()
        } label: {
          HStack {
            Label("settings.ktarget", systemImage: "target")
            Spacer()
            Text("\(String(format: "%.0f", dailyKTarget)) µg ")
          }
        }
        Stepper(
          value: $recentFoodsLimit,
          in: minimumFoodCount...maximumFoodCount
        ) {
          HStack {
            Label("settings.recent.foods.limit", systemImage: "carrot")
            Spacer()
            Text("\(recentFoodsLimit) ")
          }
        }
      }
    }
  }

  private struct TestingSettings: View {
    private let minimumProTimeInterval = 2
    private let maximumProTimeInterval = 8

    @Default(.setProTimeReminders) private var setProTimeReminders
    @Default(.defaultProTimeInterval) private var defaultProTimeInterval
    @Default(.defaultProTimeReminderTitle) private
      var defaultProTimeReminderTitle

    var body: some View {
      Group {
        Toggle(isOn: $setProTimeReminders) {
          Label("settings.testing.reminders.enabled", systemImage: "alarm")
        }
        Stepper(
          value: $defaultProTimeInterval,
          in: minimumProTimeInterval...maximumProTimeInterval
        ) {
          HStack {
            Label(
              "settings.testing.interval.default",
              systemImage: "calendar"
            )
            Spacer()
            Text("\(defaultProTimeInterval) ")
          }
        }
        VStack(alignment: .leading) {
          Label("settings.testing.title.default", systemImage: "calendar")
          TextField(
            "settings.testing.title.prompt",
            text: $defaultProTimeReminderTitle
          )
          .alignViewAndText(.leading, .trailing)
        }
      }
    }
  }

  private struct AboutSettings: View {
    @Binding var showingFDCInfo: Bool
    @Binding var showingAboutInfo: Bool

    var body: some View {
      Group {
        Button {
          showingFDCInfo.toggle()
        } label: {
          Label(
            "settings.about.fdc",
            systemImage: "fork.knife"
          )
        }
        HStack {
          Button {
            showingAboutInfo.toggle()
          } label: {
            HStack {
              Label(
                "settings.about.kfinder",
                systemImage: "apps.iphone"
              )
              Spacer()
              Text("v\(UIApplication.version)")
            }
          }
        }
      }
    }
  }
}

#if DEBUG
  #Preview {
    SettingsView()
  }
#endif
