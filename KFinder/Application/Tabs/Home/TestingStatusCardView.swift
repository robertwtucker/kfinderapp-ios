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
  @State private var shouldShowEditView = false

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
          CallToActionButtonView(
            label: "testing.status.button.enable"
          ) {
            userPreferences.setProTimeReminders.toggle()
          }
        }
      case .enabled:
        CallToActionRowView(text: "testing.status.enabled") {
          CallToActionButtonView(
            label: "testing.status.button.create"
          ) {
            Task {
              do {
                try await reminderManager.setupReminders()
                shouldShowAddView.toggle()
              } catch {
                errorHandling.handle(error: error)
                userPreferences.setProTimeReminders = false
              }
            }
          }
        }
      case .scheduled:
        if testReminder.isCompleted() {
          CallToActionRowView(text: "testing.status.completed") {
            CallToActionButtonView(
              label: "testing.status.button.create"
            ) {
              Task {
                do {
                  try await reminderManager.setupReminders()
                  shouldShowAddView.toggle()
                } catch {
                  errorHandling.handle(error: error)
                  userPreferences.setProTimeReminders = false
                }
              }
            }
          }
        } else {
          if testReminder.isOverDue() {
            CallToActionStackView(
              text:
                LocalizedStringKey(
                  "testing.status.overdue \(testReminder.isDueOn).")
            ) {
              HStack {
                CallToActionButtonView(
                  label: "testing.status.button.edit"
                ) {
                  shouldShowEditView.toggle()
                }
                Spacer()
                CallToActionButtonView(
                  label: "testing.status.button.complete"
                ) {
                  if var reminder = reminderManager.reminder {
                    reminder.isCompleted = true
                    Task {
                      do {
                        try await reminderManager.save(reminder)
                      } catch {
                        errorHandling.handle(error: error)
                      }
                    }
                  }
                }
              }
            }
          } else {
            CallToActionStackView(
              text:
                LocalizedStringKey(
                  "testing.status.scheduled \(testReminder.isDueOn).")
            ) {
              HStack {
                CallToActionButtonView(
                  label: "testing.status.button.edit"
                ) {
                  shouldShowEditView.toggle()
                }
                Spacer()
                CallToActionButtonView(
                  label: "testing.status.button.complete"
                ) {
                  if var reminder = reminderManager.reminder {
                    reminder.isCompleted = true
                    Task {
                      do {
                        try await reminderManager.save(reminder)
                      } catch {
                        errorHandling.handle(error: error)
                      }
                    }
                  }
                }
              }
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
    .sheet(isPresented: $shouldShowEditView) {
      if let reminder = reminderManager.reminder {
        EditTestReminderView(reminder)
      }
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

#if DEBUG
  #Preview {
    TestingStatusCardView()
      .environment(UserPreferences.shared)
      .environment(ReminderManager.shared)
      .environment(ErrorHandling())
  }
#endif
