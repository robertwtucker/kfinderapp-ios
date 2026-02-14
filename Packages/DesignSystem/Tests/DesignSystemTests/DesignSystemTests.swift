//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import SwiftUI
import Testing

@testable import DesignSystem

// MARK: - CGFloat Design Constants Tests

@Suite("CGFloat Design Constants")
@MainActor
struct CGFloatDesignTests {

  @Test("aboutComponentSpacing is 24")
  func aboutComponentSpacing() {
    #expect(CGFloat.aboutComponentSpacing == 24)
  }

  @Test("cornerRadius is 8")
  func cornerRadius() {
    #expect(CGFloat.cornerRadius == 8)
  }

  @Test("foodComponentPadding is 8")
  func foodComponentPadding() {
    #expect(CGFloat.foodComponentPadding == 8)
  }

  @Test("scrollToViewHeight is 1")
  func scrollToViewHeight() {
    #expect(CGFloat.scrollToViewHeight == 1)
  }
}

// MARK: - Palette Color Tests

@Suite("Palette Colors")
struct PaletteColorTests {

  @Suite("appBaseBackground")
  struct AppBaseBackground {
    @Test("dark scheme returns black")
    func dark() {
      #expect(Color.appBaseBackground(for: .dark) == .black)
    }

    @Test("light scheme returns appLightGray")
    func light() {
      #expect(Color.appBaseBackground(for: .light) == .appLightGray)
    }
  }

  @Suite("appBackground")
  struct AppBackground {
    @Test("dark scheme returns appDarkGray")
    func dark() {
      #expect(Color.appBackground(for: .dark) == .appDarkGray)
    }

    @Test("light scheme returns white")
    func light() {
      #expect(Color.appBackground(for: .light) == .white)
    }
  }

  @Suite("appBackgroundInverted")
  struct AppBackgroundInverted {
    @Test("dark scheme returns appLightGray")
    func dark() {
      #expect(Color.appBackgroundInverted(for: .dark) == .appLightGray)
    }

    @Test("light scheme returns appDarkGray")
    func light() {
      #expect(Color.appBackgroundInverted(for: .light) == .appDarkGray)
    }
  }

  @Suite("appForeground")
  struct AppForeground {
    @Test("dark scheme returns appLightGray")
    func dark() {
      #expect(Color.appForeground(for: .dark) == .appLightGray)
    }

    @Test("light scheme returns black")
    func light() {
      #expect(Color.appForeground(for: .light) == .black)
    }
  }

  @Suite("appForegroundInverted")
  struct AppForegroundInverted {
    @Test("dark scheme returns black")
    func dark() {
      #expect(Color.appForegroundInverted(for: .dark) == .black)
    }

    @Test("light scheme returns white")
    func light() {
      #expect(Color.appForegroundInverted(for: .light) == .white)
    }
  }
}
