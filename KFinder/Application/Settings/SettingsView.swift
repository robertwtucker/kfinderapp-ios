//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Services
import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Environment(UserPreferences.self) private var userPreferences

    @State private var showingKTarget = false
    @State private var showingFDCInfo = false
    @State private var showingAboutInfo = false

    var body: some View {
        VStack {
            SettingsHeaderView()
            VStack {
                Form {
                    kTargetSection
                    testingSection
                    aboutSection
                }
                .sheet(isPresented: $showingKTarget) {
                    VitaminKTargetView()
                        .presentationDetents([.fraction(0.75)])
                }
                .sheet(isPresented: $showingFDCInfo) {
                    InfoPageView(
                        info: "settings.fdc.info", footnote: "settings.fdc.footnote"
                    )
                    .presentationDetents([.fraction(0.55)])
                }
                .sheet(isPresented: $showingAboutInfo) {
                    AboutView()
                }
            }
        }
    }

    @ViewBuilder
    private var kTargetSection: some View {
        @Bindable var userPrefs = userPreferences

        Section("settings.tracking") {
            Button(
                action: {
                    showingKTarget.toggle()
                },
                label: {
                    HStack {
                        HStack {
                            Image(systemName: "target")
                            Text("settings.ktarget")
                                .foregroundStyle(Color.appForeground(for: colorScheme))
                        }
                        Spacer()
                        Text("\(String(format: "%.0f", userPreferences.dailyKTarget)) µg ")
                    }
                    .accentColor(Color.appForeground(for: colorScheme))
                }
            )
            Stepper(value: $userPrefs.recentFoodsLimit, in: 3...10) {
                HStack {
                    Image(systemName: "calendar")
                    Text("settings.recent.foods.limit")
                    Spacer()
                    Text("\(userPrefs.recentFoodsLimit) ")
                }
            }
        }
    }

    @ViewBuilder
    private var testingSection: some View {
        @Bindable var userPrefs = userPreferences

        Section("settings.testing") {
            Toggle(isOn: $userPrefs.setProTimeReminders) {
                HStack {
                    Image(systemName: "alarm")
                    Text("settings.testing.enabled")
                }
            }
            .accentColor(Color.appForeground(for: colorScheme))
            Stepper(value: $userPrefs.defaultProTimeInterval, in: 2...6) {
                HStack {
                    Image(systemName: "calendar")
                    Text("settings.testing.interval.default")
                    Spacer()
                    Text("\(userPrefs.defaultProTimeInterval) ")
                }
            }
            .accentColor(Color.appForeground(for: colorScheme))
        }
    }

    private var aboutSection: some View {
        Section("settings.about") {
            Button(
                action: {
                    showingFDCInfo.toggle()
                },
                label: {
                    Label(
                        "settings.about.fdc", systemImage: "fork.knife"
                    )
                    .foregroundStyle(Color.appForeground(for: colorScheme))
                }
            )
            .accentColor(Color.appForeground(for: colorScheme))
            HStack {
                Button(
                    action: {
                        showingAboutInfo.toggle()
                    },
                    label: {
                        HStack {
                            Label(
                                "settings.about.kfinder", systemImage: "apps.iphone"
                            )
                            .foregroundStyle(Color.appForeground(for: colorScheme))
                            Spacer()
                            Text("v\(UIApplication.version)")
                        }
                    }
                )
                .accentColor(Color.appForeground(for: colorScheme))
            }
        }
    }
}

struct SettingsHeaderView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        HStack {
            Text("settings.title")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Spacer()
            Button(
                action: {
                    dismiss()
                },
                label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding()
                }
            )
            .accentColor(Color.appForeground(for: colorScheme))
        }
    }
}

#Preview {
    SettingsView()
        .environment(UserPreferences.shared)
}
