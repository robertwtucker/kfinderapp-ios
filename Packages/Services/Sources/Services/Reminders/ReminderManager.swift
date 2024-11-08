//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

@preconcurrency import EventKit
import Models
import OSLog
import SwiftUI

@MainActor
@Observable public class ReminderManager {
  public var reminder: Reminder? = nil

  public static let shared = ReminderManager()
  private let reminderStore: ReminderStore

  private init(store: ReminderStore = ReminderStore()) {
    self.reminderStore = store
  }

  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: ReminderManager.self))
  
  public func setupReminders() async throws {
    guard UserPreferences.shared.setProTimeReminders else { return }

    if try await reminderStore.verifyAuthorizationStatus() {
      do {
        try await fetch(with: UserPreferences.shared.proTimeReminderId)
      } catch {
        print(
          "Setup error fetching reminder with ID: \(UserPreferences.shared.proTimeReminderId)"
        )
        reminder = nil
        UserPreferences.shared.proTimeReminderId = ""
      }
    }
  }

  public func add(_ reminder: Reminder) async throws {
    guard reminderStore.isFullAccessAvailable() else {
      throw ReminderStoreError.accessDenied
    }
    logger.debug("Adding reminder with ID: \(reminder.id)")
    let id = try reminderStore.save(reminder)
    logger.debug("Reminder saved with ID: \(id)")
    UserPreferences.shared.proTimeReminderId = id
    try await fetch(with: id)
  }

  public func fetch(with id: String) async throws {
    reminder = try reminderStore.fetch(with: id)
    logger.debug("Reminder fetched with ID: \(id)")
  }

  public func remove(with id: String) async throws {
    guard reminderStore.isFullAccessAvailable() else {
      throw ReminderStoreError.accessDenied
    }
    try reminderStore.remove(with: id)
    reminder = nil
    logger.debug("Reminder removed with ID: \(id)")
  }

  public func listenForReminderChanges() async throws {
    let center = NotificationCenter.default
    let notifications = center.notifications(named: .EKEventStoreChanged).map({
      (notification: Notification) in notification.name
    })

    for await _ in notifications {
      guard reminderStore.isFullAccessAvailable() else { return }
      guard let reminder = self.reminder else { return }
      self.reminder = try reminderStore.fetch(with: reminder.id)
    }
  }

}
