//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

@preconcurrency import EventKit

import Defaults
import Models
import OSLog
import SwiftUI

@MainActor
@Observable public class ReminderManager {
  public var reminder: Reminder?

  public static let shared = ReminderManager()
  private let reminderStore: ReminderStore

  private init(store: ReminderStore = ReminderStore()) {
    self.reminderStore = store
  }

  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: ReminderManager.self))

  public func setupReminders() async throws {
    guard Defaults[.setProTimeReminders] else { return }

    if try await reminderStore.verifyAuthorizationStatus() {
      let reminderId = Defaults[.proTimeReminderId]
      if !reminderId.isEmpty {
        do {
          logger.debug(
            "[RM Setup] Calling fetch for Reminder(id: \(reminderId))"
          )
          try await fetch(with: reminderId)
        } catch {
          logger.error(
            "[RM Setup] Error fetching Reminder(id: \(reminderId))"
          )
          reminder = nil
          Defaults[.proTimeReminderId] = ""
        }
      }
    }
  }

  public func save(_ reminder: Reminder) async throws {
    guard reminderStore.isFullAccessAvailable() else {
      throw ReminderStoreError.accessDenied
    }
    logger.debug("[RM] Saving reminder with ID: \(reminder.id)")
    let id = try reminderStore.save(reminder)
    logger.debug("[RM] Saved Reminder(id: \(id))")
    Defaults[.proTimeReminderId] = id
    try await fetch(with: id)
  }

  public func fetch(with id: String) async throws {
    guard let reminder = try reminderStore.fetch(with: id) else {
      logger.debug("[RM] Fetch of Reminder(id: \(id)) returned nil")
      Defaults[.proTimeReminderId] = ""
      self.reminder = nil
      return
    }
    logger.debug("[RM] Fetched Reminder(id: \(id))")
    self.reminder = reminder
  }

  public func remove(with id: String) async throws {
    guard reminderStore.isFullAccessAvailable() else {
      throw ReminderStoreError.accessDenied
    }
    try reminderStore.remove(with: id)
    reminder = nil
    logger.debug("[RM] Removed Reminder(id: \(id))")
  }

  public func listenForReminderChanges() async {
    let center = NotificationCenter.default
    let notifications = center.notifications(
      named: .EKEventStoreChanged,
      object: reminderStore.eventStore
    ).map({ (notification: Notification) in
      notification.name
    })

    for await _ in notifications {
      logger.debug("[RM Listener] Received EKEventStoreChanged notification")
      guard reminderStore.isFullAccessAvailable() else { return }
      guard let reminder = self.reminder else { return }
      do {
        if try reminderStore.refresh(with: reminder.id) {
          logger.debug("[RM Listener] Refreshing Reminder(id: \(reminder.id))")
          try await fetch(with: reminder.id)
        }
      } catch {
        // Our reminder was most likely deleted.
        logger.error(
          "[RM Listener] Failed to refresh Reminder(id: \(reminder.id))")
        Defaults[.proTimeReminderId] = ""
        self.reminder = nil
      }
    }
  }
}
