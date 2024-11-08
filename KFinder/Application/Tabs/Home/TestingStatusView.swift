//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Services
import SwiftUI

struct TestingStatusView: View {
  @Environment(\.colorScheme) private var colorScheme
  @Environment(UserPreferences.self) private var userPreferences
  @Environment(ReminderManager.self) private var reminderManager

  @State private var showAddView = false

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        HStack {
          Image(systemName: "heart.text.clipboard")
          Text("testing.status.card.title")
        }
        .font(.headline)
        .padding()
        Spacer()
      }
      TestReminderView()
        .padding()
    }
    .background(
      RoundedRectangle(cornerRadius: 8)
        .fill(Color.appBackground(for: colorScheme))
        .shadow(radius: 1, x: 1, y: 1)
    )
    .sheet(isPresented: $showAddView) {
      AddTestReminderView()
    }
    .onAppear {
      if userPreferences.setProTimeReminders
        && !userPreferences.proTimeReminderId.isEmpty
      {
        Task {
          try await reminderManager.setupReminders()
        }
      }
    }

  }

  private func TestReminderView() -> some View {
    VStack {
      if userPreferences.setProTimeReminders {
        if userPreferences.proTimeReminderId.isEmpty {
          TestsEnabledView()
        } else {
          TestScheduledView()
        }
      } else {
        TestsDisabledView()
      }
    }
  }

  private func TestScheduledView() -> some View {
    VStack {
      HStack {
        Text("testing.status.scheduled")
          .font(.callout)
          + Text(
            " \(reminderManager.reminder?.dueDate ?? Date.distantPast, formatter: .dueDateFormatter)."
          )
          .font(.callout).bold()
        Spacer()
      }
      .padding(.bottom)
      HStack {
        Spacer()
        Button(action: {
          guard let url = URL(string: "x-apple-reminderkit://") else { return }
          if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
          }
        }) {
          Text("testing.status.button.open")
            .font(.callout)
            .padding()
            .background(Color.appBackgroundInverted(for: colorScheme))
            .cornerRadius(8)
        }
        .accentColor(Color.appForegroundInverted(for: colorScheme))
      }
    }
  }

  private func TestsEnabledView() -> some View {
    HStack {
      Text("testing.status.enabled")
        .font(.callout)
      Spacer()
      Button(action: {
        Task {
          try await reminderManager.setupReminders()
          showAddView.toggle()
        }
      }) {
        Text("testing.status.button.create")
          .font(.callout)
          .padding()
          .background(Color.appBackgroundInverted(for: colorScheme))
          .cornerRadius(8)
      }
      .accentColor(Color.appForegroundInverted(for: colorScheme))
    }
  }

  private func TestsDisabledView() -> some View {
    HStack {
      Text("testing.status.disabled")
        .font(.callout)
      Spacer()
      Button(
        action: {
          userPreferences.setProTimeReminders.toggle()
        }) {
          Text("testing.status.button.enable")
            .font(.callout)
            .padding()
            .background(Color.appBackgroundInverted(for: colorScheme))
            .cornerRadius(8)
        }
        .accentColor(Color.appForegroundInverted(for: colorScheme))
    }
  }
}

#Preview {
  TestingStatusView()
    .environment(UserPreferences.shared)
    .environment(ReminderManager.shared)
}
