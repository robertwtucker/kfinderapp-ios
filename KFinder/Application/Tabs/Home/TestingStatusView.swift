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
    @Bindable var statusHelper = TestingStatusHelper()

    VStack(alignment: .leading) {
      HStack {
        HStack {
          Image(systemName: "heart.text.clipboard")
          Text("testing.status.card.title")
        }
        .font(.headline)
        .padding(.top)
        .padding(.horizontal)
        Spacer()
      }
      switch statusHelper.status {
      case .disabled:
        testsDisabledView()
      case .enabled:
        testsEnabledView()
      case .scheduled:
        if statusHelper.reminderIsComplete() {
          testCompletedView()
        } else {
          testScheduledView(statusHelper)
        }
      }
    }
    .background(
      RoundedRectangle(cornerRadius: .cornerRadius)
        .fill(Color.appBackground(for: colorScheme))
        .withCardShadow()
    )
    .sheet(isPresented: $showAddView) {
      AddTestReminderView()
    }
    .onAppear {
      Task {
        try await reminderManager.setupReminders()
      }
    }
  }

  private func testScheduledView(_ helper: TestingStatusHelper) -> some View {
    VStack {
      HStack {
        if helper.reminderIsOverdue() {
          Text("testing.status.overdue")
            .font(.callout)
            + Text(
              " \(helper.reminderDueDate)."
            )
            .font(.callout).bold()
        } else {
          Text("testing.status.scheduled")
            .font(.callout)
            + Text(
              " \(helper.reminderDueDate)."
            )
            .font(.callout).bold()
        }
        Spacer()
        Button(
          action: {
            guard let url = URL(string: "x-apple-reminderkit://") else {
              return
            }
            if UIApplication.shared.canOpenURL(url) {
              UIApplication.shared.open(url)
            }
          },
          label: {
            Text("testing.status.button.open")
              .font(.callout)
              .padding()
              .background(Color.appBackgroundInverted(for: colorScheme))
              .cornerRadius(.cornerRadius)
          }
        )
        .accentColor(Color.appForegroundInverted(for: colorScheme))
      }
      .padding()
    }
  }

  private func testCompletedView() -> some View {
    HStack {
      Text("testing.status.completed")
        .font(.callout)
      Spacer()
      Button(
        action: {
          Task {
            try await reminderManager.setupReminders()
            showAddView.toggle()
          }
        },
        label: {
          Text("testing.status.button.create")
            .font(.callout)
            .padding()
            .background(Color.appBackgroundInverted(for: colorScheme))
            .cornerRadius(8)
        }
      )
      .accentColor(Color.appForegroundInverted(for: colorScheme))
    }
    .padding()
  }

  private func testsEnabledView() -> some View {
    HStack {
      Text("testing.status.enabled")
        .font(.callout)
      Spacer()
      Button(
        action: {
          Task {
            try await reminderManager.setupReminders()
            showAddView.toggle()
          }
        },
        label: {
          Text("testing.status.button.create")
            .font(.callout)
            .padding()
            .background(Color.appBackgroundInverted(for: colorScheme))
            .cornerRadius(8)
        }
      )
      .accentColor(Color.appForegroundInverted(for: colorScheme))
    }
    .padding()
  }

  private func testsDisabledView() -> some View {
    HStack {
      Text("testing.status.disabled")
        .font(.callout)
      Spacer()
      Button(
        action: {
          userPreferences.setProTimeReminders.toggle()
        },
        label: {
          Text("testing.status.button.enable")
            .font(.callout)
            .padding()
            .background(Color.appBackgroundInverted(for: colorScheme))
            .cornerRadius(8)
        }
      )
      .accentColor(Color.appForegroundInverted(for: colorScheme))
    }
    .padding()
  }
}

#if DEBUG
  #Preview {
    TestingStatusView()
      .environment(UserPreferences.shared)
      .environment(ReminderManager.shared)
  }
#endif
