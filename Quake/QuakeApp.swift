//
//  QuakeApp.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 11/01/2024.
//

import SwiftUI

@main
@MainActor
struct QuakeApp: App {
    
    @StateObject var quakeProvider = QuakesProvider()
    
    var body: some Scene {
        WindowGroup {
            Quakes()
                .environmentObject(quakeProvider)
        }
    }
}
