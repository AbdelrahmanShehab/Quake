//
//  QuakeDetail.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 22/01/2024.
//

import SwiftUI

struct QuakeDetail: View {
    let quake: Quake
    
    @EnvironmentObject private var quakeProvider: QuakesProvider
    @State private var location: QuakeLocation? = nil
    
    var body: some View {
        VStack {
            if let location = self.location {
                QuakeDetailMap(location: location, tintColor: quake.color)
                    .ignoresSafeArea(.container)
            }
            QuakeMagnitude(quake: quake)
            
            Text("\(quake.place)")
                .font(.title3)
                .bold()
            Text("\(quake.time.formatted())")
                .foregroundStyle(.secondary)
            
            if let location = self.location {
                Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
                Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
                
            }
        }
        .task {
            if self.location == nil {
                if let quakeLocation = quake.location {
                    self.location = quakeLocation
                } else {
                    self.location = try? await quakeProvider.location(for: quake)
                }
            }
        }
    }
}

#Preview {
    QuakeDetail(quake: Quake.preview)
}
