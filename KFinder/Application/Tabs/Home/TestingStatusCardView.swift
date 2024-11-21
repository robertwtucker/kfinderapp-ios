//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Services
import SwiftUI

struct TestingStatusCardView: View {
  @Environment(\.colorScheme) private var colorScheme
  @Environment(UserPreferences.self) private var userPreferences
  @Environment(ReminderManager.self) private var reminderManager

  @State private var shouldShowAddView = false

  var body: some View {
    @Bindable var testReminder = TestReminderModel(reminderManager.reminder)

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
      switch testReminder.status {
      case .disabled:
        buildTestsDisabledView()
      case .enabled:
        buildTestsEnabledView()
      case .scheduled:
        if testReminder.isCompleted() {
          buildReminderCompletedView()
        } else {
          if testReminder.isOverDue() {
            buildReminderOverdueView(testReminder.isDueOn)
          } else {
            buildReminderScheduledView(testReminder.isDueOn)
          }
        }
      }
    }
    .background(
      RoundedRectangle(cornerRadius: .cornerRadius)
        .fill(Color.appBackground(for: colorScheme))
        .withCardShadow()
    )
    .sheet(isPresented: $shouldShowAddView) {
      AddTestReminderView()
    }
    .task {
      do {
        try await reminderManager.setupReminders()
      } catch {
        //
      }
    }
  }

  private func buildReminderScheduledView(_ due: String) -> some View {
    let ctaMessage = LocalizedStringKey(
      "testing.status.scheduled \(due).")
    return CallToActionRowView(text: ctaMessage) {
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
            .asCallToActionButton(colorScheme: colorScheme)
        }
      )
    }
  }

  private func buildReminderOverdueView(_ due: String)
  -> some View {
    let ctaMessage = LocalizedStringKey(
      "testing.status.overdue \(due).")
    return CallToActionRowView(text: ctaMessage) {
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
            .asCallToActionButton(colorScheme: colorScheme)
        }
      )
    }
  }

  private func buildReminderCompletedView() -> some View {
    return CallToActionRowView(text: "testing.status.completed") {
      Button(
        action: {
          Task {
            try await reminderManager.setupReminders()
            shouldShowAddView.toggle()
          }
        },
        label: {
          Text("testing.status.button.create")
            .asCallToActionButton(colorScheme: colorScheme)
        }
      )
    }
  }

  private func buildTestsEnabledView() -> some View {
    return CallToActionRowView(text: "testing.status.enabled") {
      Button(
        action: {
          Task {
            try await reminderManager.setupReminders()
            shouldShowAddView.toggle()
          }
        },
        label: {
          Text("testing.status.button.create")
            .asCallToActionButton(colorScheme: colorScheme)
        }
      )
    }
  }

  private func buildTestsDisabledView() -> some View {
    return CallToActionRowView(text: "testing.status.disabled") {
      Button(
        action: {
          userPreferences.setProTimeReminders.toggle()
        },
        label: {
          Text("testing.status.button.enable")
            .asCallToActionButton(colorScheme: colorScheme)
        }
      )
    }
  }

}

struct CallToActionRowView<Content: View>: View {
  @Environment(\.colorScheme) private var colorScheme

  let text: LocalizedStringKey
  @ViewBuilder let content: Content

  var body: some View {
    HStack {
      Text(text)
        .font(.callout)
      Spacer()
      content
    }
    .accentColor(Color.appForegroundInverted(for: colorScheme))
    .padding()
  }
}

struct CallToActionStackView<Content: View>: View {
  @Environment(\.colorScheme) private var colorScheme

  let text: LocalizedStringKey
  @ViewBuilder let content: Content

  var body: some View {
    VStack(alignment: .leading) {
      Text(text)
        .font(.callout)
      content
    }
    .accentColor(Color.appForegroundInverted(for: colorScheme))
    .padding()
  }
}

#if DEBUG
  #Preview {
    TestingStatusCardView()
      .environment(UserPreferences.shared)
      .environment(ReminderManager.shared)
  }
#endif
