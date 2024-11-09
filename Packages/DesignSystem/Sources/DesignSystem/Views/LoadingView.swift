//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import SwiftUI

public struct LoadingView: View {
    public var body: some View {
        VStack {
            ProgressView()
            Spacer()
        }
        .padding()
    }

    public init() { }
}

#Preview {
    LoadingView()
}
