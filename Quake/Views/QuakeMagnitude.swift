//
//  QuakeMagnitude.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 13/01/2024.
//

import SwiftUI

struct QuakeMagnitude: View {
    var quake: Quake
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(colorScheme == .dark ? .white : .black)
            .frame(width: 80, height: 60)
            .shadow(radius: 8)
            .overlay {
                Text("\(quake.magnitude.formatted(.number.precision(.fractionLength(1))))")
                    .foregroundStyle(quake.color)
                    .font(.title)
                    .bold()
            }
    }
}

#Preview {
    QuakeMagnitude(quake: Quake(magnitude: 1.0,
                                place: "Shakey Acres",
                                time: Date(timeIntervalSinceNow: -1000),
                                code: "nc73649170",
                                detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!))
}
