//
//  QuakeRow.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 13/01/2024.
//

import SwiftUI

struct QuakeRow: View {
    var quake: Quake
    
    var body: some View {
        
        HStack(content: {
            QuakeMagnitude(quake: quake)
            VStack(alignment: .leading, content: {
                Text("\(quake.place)")
                    .font(.title3)
                Text("\(quake.time.formatted(.relative(presentation: .named)))")
                    .foregroundStyle(.secondary)
            })
        })
        .padding(.vertical, 8)
    }
}

#Preview {
    QuakeRow(quake: Quake(magnitude: 1.0,
                          place: "Shakey Acres",
                          time: Date(timeIntervalSinceNow: -1000),
                          code: "nc73649170",
                          detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!))
}
