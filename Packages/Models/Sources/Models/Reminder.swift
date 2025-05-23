//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation

public struct Reminder: Equatable, Identifiable {
  public var id: String = UUID().uuidString
  public var title: String
  public var dueDate: Date
  public var notes: String?
  public var isCompleted: Bool = false

  public init(
    id: String = UUID().uuidString, title: String, dueDate: Date,
    notes: String? = nil, isCompleted: Bool = false
  ) {
    self.id = id
    self.title = title
    self.dueDate = dueDate
    self.notes = notes
    self.isCompleted = isCompleted
  }
}

// MARK: - Samples
#if DEBUG
  extension Reminder: @unchecked Sendable {
    public static let sample = Reminder(
      id: "sampleid",
      title: "Get PT/INR Tested",
      dueDate: Date.now.addingTimeInterval(3600),
      notes: "Test regularly and often."
    )
  }
#endif
