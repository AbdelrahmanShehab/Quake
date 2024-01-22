//
//  QuakeDetailMap.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 22/01/2024.
//

import SwiftUI
import MapKit

struct QuakeDetailMap: View {
    @State private var region = MKCoordinateRegion()
    
    let location: QuakeLocation
    let tintColor: Color
    private var place: QuakePlace
    
    init(location: QuakeLocation, tintColor: Color) {
        self.location = location
        self.tintColor = tintColor
        self.place = QuakePlace(location: location)
    }
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [place], annotationContent: { place in
            MapMarker(coordinate: place.location, tint: tintColor)
        })
            .onAppear(perform: {
                withAnimation {
                    region.center = place.location
                    region.span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                }
            })
    }
}

struct QuakePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), location: QuakeLocation) {
        self.id = id
        self.location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
}
