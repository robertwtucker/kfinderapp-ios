//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import Services
import SwiftUI

struct AddTestReminderView: View {
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.dismiss) var dismiss
  @Environment(ReminderManager.self) var reminderManager
  @Environment(UserPreferences.self) var userPreferences

  @State private var reminderDate = Date.now

  var body: some View {
    VStack {
      HStack {
        Text("test.add.reminder.title")
          .font(.title2).bold()
          .padding()
        Spacer()
        Button(
          action: {
            dismiss()
          },
          label: {
            Image(systemName: "xmark")
              .font(.title2).bold()
              .padding()
          }
        )
        .accentColor(Color.appForeground(for: colorScheme))
      }
      DatePicker(
        "test.reminder.date",
        selection: $reminderDate,
        displayedComponents: .date
      )
      .datePickerStyle(.graphical)
      DatePicker(
        "test.reminder.time",
        selection: $reminderDate,
        displayedComponents: .hourAndMinute
      )
      .padding()
      HStack {
        Button(
          action: {
            dismiss()
          },
          label: {
            Text("button.cancel")
              .font(.callout)
              .padding(.vertical, 16)
              .padding(.horizontal, 32)
          }
        )
        .accentColor(Color.appForeground(for: colorScheme))
        Spacer()
        Button(
          action: {
            let reminder = Reminder(
              title: String(localized: "test.reminder.title"),
              dueDate: reminderDate)
            Task {
              try await reminderManager.add(reminder)
            }
            dismiss()
          },
          label: {
            Text("button.save")
              .font(.callout)
              .padding(.vertical, 16)
              .padding(.horizontal, 32)
              .background(Color.appBackgroundInverted(for: colorScheme))
              .cornerRadius(8)
          }
        )
        .accentColor(Color.appForegroundInverted(for: colorScheme))
      }
      .padding()
      Spacer()
    }
    .onAppear {
      reminderDate = setDefaults(from: Date.now)
    }
  }

  private func setDefaults(from date: Date) -> Date {
    let defaultDate = date.addingTimeInterval(
      .week * Double(userPreferences.defaultProTimeInterval))
    var components = Calendar.current.dateComponents(
      [.year, .month, .day], from: defaultDate)
    components.hour = 8
    return Calendar.current.date(from: components) ?? defaultDate
  }
}

#Preview {
  AddTestReminderView()
    .environment(ReminderManager.shared)
    .environment(UserPreferences.shared)
}
