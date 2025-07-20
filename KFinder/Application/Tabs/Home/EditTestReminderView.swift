//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import Services
import SwiftUI
import TelemetryDeck

struct EditTestReminderView: View {
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.dismiss) var dismiss
  @Environment(ReminderManager.self) var reminderManager
  @Environment(UserPreferences.self) var userPreferences
  @Environment(ErrorHandling.self) var errorHandling

  @State var reminder: Reminder

  init(_ reminder: Reminder) {
    _reminder = State(initialValue: reminder)
  }

  var body: some View {
    VStack {
      HStack {
        Text("test.edit.reminder.title")
          .font(.title2).bold()
          .padding()
        Spacer()
        Button {
          dismiss()
        } label: {
          Image(systemName: "xmark")
            .font(.title2).bold()
            .padding()
        }
      }
      TextField(
        "test.reminder.title",
        text: $reminder.title
      )
      .padding()
      DatePicker(
        "test.reminder.date",
        selection: $reminder.dueDate,
        displayedComponents: .date
      )
      .datePickerStyle(.graphical)
      DatePicker(
        "test.reminder.time",
        selection: $reminder.dueDate,
        displayedComponents: .hourAndMinute
      )
      .padding()
      HStack {
        Button {
          dismiss()
        } label: {
          Text("button.cancel")
            .font(.callout)
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
        }
        Spacer()
        Button {
          if reminder.title.isEmpty {
            reminder.title = String(localized: "test.reminder.title")
          }
          Task {
            do {
              try await reminderManager.save(reminder)
            } catch {
              errorHandling.handle(error: error)
            }
          }
          TelemetryDeck.signal("reminder.edited")
          dismiss()
        } label: {
          Text("button.save")
            .font(.callout)
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
            .background(Color.appBackgroundInverted(for: colorScheme))
            .cornerRadius(8)
        }
        .accentColor(Color.appForegroundInverted(for: colorScheme))
      }
      .padding(32)
      Spacer()
    }
  }
}

#if DEBUG
  #Preview {
    EditTestReminderView(Reminder.sample)
      .environment(ReminderManager.shared)
      .environment(UserPreferences.shared)
      .environment(ErrorHandling())
  }
#endif
