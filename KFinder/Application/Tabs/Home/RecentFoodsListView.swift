//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import Services
import SwiftData
import SwiftUI

struct RecentFoodsListView: View {
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.modelContext) private var modelContext
  @Environment(\.defaultMinListRowHeight) var minRowHeight

  // Store is bounded by `UserPreferences.enforceRecentFoodsLimit()` (#95);
  // no `fetchLimit` needed here.
  @Query(sort: \RecentFood.viewedAt, order: .reverse) private var foods: [RecentFood]

  // Rehydrates a tapped Recent into a full `FoodItem` via the FDC detail
  // endpoint; see issue #96.
  private let service = FoodDataCentralService(
    apiKey: Secrets.FoodDataCentral.apiKey ?? "")
  @State private var loadingFdcId: Int?
  @State private var navigationTarget: FoodItem?
  @State private var fetchError: FetchError?

  private struct FetchError: Identifiable {
    let id = UUID()
    let message: String
  }

  var body: some View {
    if foods.count > 0 {
      ForEach(foods, id: \.self) { food in
        Button {
          Task { await rehydrate(food) }
        } label: {
          RecentFoodCellView(food: food)
            .overlay(alignment: .trailing) {
              if loadingFdcId == food.fdcId {
                ProgressView()
                  .padding(.trailing)
              }
            }
        }
        .buttonStyle(.plain)
        .disabled(loadingFdcId != nil)
        .padding(.vertical)
        .background(
          RoundedRectangle(cornerRadius: .cornerRadius)
            .fill(Color.appBackground(for: colorScheme))
            .withCardShadow()
        )
        .contextMenu {
          Button {
            modelContext.delete(food)
          } label: {
            Label("foods.recent.remove", systemImage: "trash")
          }
        }
      }
      .navigationDestination(item: $navigationTarget) { food in
        FoodDetailView(food: food)
      }
      .alert(
        "foods.recent.fetch.error",
        isPresented: Binding(
          get: { fetchError != nil },
          set: { if !$0 { fetchError = nil } }
        ),
        presenting: fetchError
      ) { _ in
        Button("alert.dismiss", role: .cancel) { fetchError = nil }
      } message: { error in
        Text(error.message)
      }
    } else {
      VStack(alignment: .leading) {
        HStack {
          HStack {
            Image(systemName: "carrot")
            Text("foods.recent.none")
          }
          .font(.headline)
          Spacer()
        }
        .padding(.vertical)
        Text("foods.recent.none.message")
          .font(.subheadline)
          .padding(.bottom)
      }
      .padding(.horizontal)
      .background(
        RoundedRectangle(cornerRadius: .cornerRadius)
          .fill(Color.appBackground(for: colorScheme))
          .withCardShadow()
      )
    }
  }

  @MainActor
  private func rehydrate(_ food: RecentFood) async {
    guard loadingFdcId == nil else { return }
    loadingFdcId = food.fdcId
    defer { loadingFdcId = nil }
    do {
      let item = try await service.fetchFood(by: food.fdcId)
      navigationTarget = item
    } catch {
      fetchError = FetchError(
        message: String(localized: "foods.recent.fetch.error.message"))
    }
  }
}

#if DEBUG
#Preview {
  RecentFoodsListView()
    .environment(UserPreferences.shared)
    .modelContainer(previewContainer)
}
#endif
