//
//  QuakesProvider.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 11/01/2024.
//

import Foundation

@MainActor
class QuakesProvider: ObservableObject {
    @Published var quakes: [Quake] = []
    
    let client: QuakeClient
    
    func fetchQuakes() async throws {
        let latestQuakes = try await client.quakes
        self.quakes = latestQuakes
    }
    
    func deleteQuake(atOffsets offsets: IndexSet) {
        quakes.remove(atOffsets: offsets)
    }
    init(client: QuakeClient = QuakeClient()) {
        self.client = client
    }
}
