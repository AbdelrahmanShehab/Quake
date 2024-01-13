//
//  RefreshButton.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 13/01/2024.
//

import SwiftUI

struct RefreshButton: View {
    
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action, label: {
            Label("Refresh", systemImage: "arrow.clockwise")
        })
    }
}

#Preview {
    RefreshButton()
}
