//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Defaults
import Models
import Services
import SwiftUI
import TelemetryDeck

struct AddTestReminderView: View {
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.dismiss) var dismiss
  @Environment(ReminderManager.self) var reminderManager
  @Environment(ErrorHandling.self) var errorHandling

  @State private var reminderTitle = String(localized: "test.reminder.title")
  @State private var reminderDueDate = Date.now

  var body: some View {
    VStack {
      HStack {
        Text("test.add.reminder.title")
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
        text: $reminderTitle
      )
      .padding()
      DatePicker(
        "test.reminder.date",
        selection: $reminderDueDate,
        displayedComponents: .date
      )
      .datePickerStyle(.graphical)
      DatePicker(
        "test.reminder.time",
        selection: $reminderDueDate,
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
          let reminder = Reminder(
            title: reminderTitle,
            dueDate: reminderDueDate,
            notes: String(localized: "test.reminder.notes")
          )
          Task {
            do {
              try await reminderManager.save(reminder)
            } catch {
              errorHandling.handle(error: error)
            }
          }
          TelemetryDeck.signal("reminder.added")
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
    .onAppear {
      reminderTitle =
        Defaults[.defaultProTimeReminderTitle].isEmpty
        ? String(localized: "test.reminder.title")
        : Defaults[.defaultProTimeReminderTitle]
      reminderDueDate = setDefaultReminder(from: Date.now)
    }
  }

  private func setDefaultReminder(from date: Date) -> Date {
    let defaultDate = date.addingTimeInterval(
      .week * Double(Defaults[.defaultProTimeInterval])
    )
    var components = Calendar.current.dateComponents(
      [.year, .month, .day],
      from: defaultDate
    )
    components.hour = 8
    return Calendar.current.date(from: components) ?? defaultDate
  }

}

#if DEBUG
  #Preview {
    AddTestReminderView()
      .environment(ReminderManager.shared)
      .environment(ErrorHandling())
  }
#endif
