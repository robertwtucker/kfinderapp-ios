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
  @Environment(ErrorHandling.self) private var errorHandling

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
        CallToActionRowView(text: "testing.status.disabled") {
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
      case .enabled:
        CallToActionRowView(text: "testing.status.enabled") {
          CreateReminderButton(sheetIsPresented: $shouldShowAddView)
        }
      case .scheduled:
        if testReminder.isCompleted() {
          CallToActionRowView(text: "testing.status.completed") {
            CreateReminderButton(sheetIsPresented: $shouldShowAddView)
          }
        } else {
          if testReminder.isOverDue() {
            CallToActionRowView(
              text:
                LocalizedStringKey(
                  "testing.status.overdue \(testReminder.isDueOn).")
            ) {
              RemindersButton()
            }
          } else {
            CallToActionRowView(
              text:
                LocalizedStringKey(
                  "testing.status.scheduled \(testReminder.isDueOn).")
            ) {
              RemindersButton()
            }
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
        errorHandling.handle(error: error)
        userPreferences.setProTimeReminders = false
      }
    }
  }

}

struct RemindersButton: View {
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
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

struct CreateReminderButton: View {
  @Environment(\.colorScheme) private var colorScheme
  @Environment(ReminderManager.self) private var reminderManager
  @Environment(UserPreferences.self) private var userPreferences
  @Environment(ErrorHandling.self) private var errorHandling

  @Binding var sheetIsPresented: Bool

  var body: some View {
    Button(
      action: {
        Task {
          do {
            try await reminderManager.setupReminders()
            sheetIsPresented.toggle()
          } catch {
            errorHandling.handle(error: error)
            userPreferences.setProTimeReminders = false
          }
        }
      },
      label: {
        Text("testing.status.button.create")
          .asCallToActionButton(colorScheme: colorScheme)
      }
    )
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
