//
//  ToolbarStatus.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 13/01/2024.
//

import SwiftUI

struct ToolbarStatus: View {
    var isLoading: Bool
    var lastUpdated: TimeInterval
    var quakeCount: Int
    
    var body: some View {
        VStack(content: {
            if isLoading {
                Text("Checking for Earthquakes...")
                Spacer()
            } else if lastUpdated == Date.distantFuture.timeIntervalSince1970 {
                Spacer()
                Text("\(quakeCount) Earthquakes")
                    .foregroundStyle(.secondary)
            } else {
                let lastUpdatedDate = Date(timeIntervalSince1970: lastUpdated)
                Text("Updated \(lastUpdatedDate.formatted(.relative(presentation: .named)))")
                Text("\(quakeCount) Earthquakes")
                    .foregroundStyle(.secondary)
            }
        })
        .font(.caption)
    }
}

#Preview {
    ToolbarStatus(isLoading: false, lastUpdated: Date.distantPast.timeIntervalSince1970, quakeCount: 250)
}
