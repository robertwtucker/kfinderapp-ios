//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import Services
import SwiftUI

struct RecentFoodCellView: View {
  @Environment(UserPreferences.self) private var userPreferences

  let food: RecentFood

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(food.name)
          .font(.headline)
        Text(food.category ?? "")
          .font(.subheadline)
      }
      Spacer()
      Image(
        systemName: "ellipsis.circle",
        variableValue: vitaminKPercent
      )
      .symbolRenderingMode(.monochrome)
      .foregroundColor(vitaminKColor)
      .font(.title)
    }
    .padding(.horizontal)
  }

  private var vitaminKPercent: Double {
    let target = userPreferences.dailyKTarget
    guard let vitaminK = food.vitaminKPer100g, vitaminK > 0, target > 0 else { return 0 }
    return vitaminK / target
  }

  private var vitaminKColor: Color {
    switch vitaminKPercent * 100 {
    case 0: return .gray
    case 1..<25: return .green
    case 25..<50: return .yellow
    case 50..<75: return .orange
    case 75...: return .red
    default: return .gray
    }
  }
}

#if DEBUG
  #Preview {
    RecentFoodCellView(food: RecentFood.samples[1])
      .environment(UserPreferences.shared)
  }
#endif
