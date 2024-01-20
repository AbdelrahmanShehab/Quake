//
//  QuakeClient.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 11/01/2024.
//

import Foundation

actor QuakeClient {
    
    private let quakeCache: NSCache<NSString, CacheEntryObject> = NSCache()
    
    var quakes: [Quake] {
        get async throws {
            let data = try await downloader.HTTPData(from: feedURL)
            let allQuakes = try decoder.decode(GeoJSON.self, from: data)
            var updateQuakes = allQuakes.quakes
            if let olderThanOneHour = updateQuakes.firstIndex(where: { $0.time.timeIntervalSince1970 > 3600 }) {
                let indexRange = updateQuakes.startIndex..<olderThanOneHour
                try await withThrowingTaskGroup(of: (Int, QuakeLocation).self) { group in
                    for index in indexRange {
                        group.addTask {
                            let location = try await self.quakeLocation(from: allQuakes.quakes[index].detail)
                            return (index, location)
                        }
                    }
                    while let result = await group.nextResult() {
                        switch result {
                        case .success(let (index, location)):
                            updateQuakes[index].location = location
                        case .failure(let error):
                            throw error
                        }
                    }
                }
            }
            return allQuakes.quakes
        }
    }
    
    private lazy var decoder: JSONDecoder = {
        let aDeocder = JSONDecoder()
        aDeocder.dateDecodingStrategy = .millisecondsSince1970
        return aDeocder
    }()
    
    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!

    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    func quakeLocation(from url: URL) async throws -> QuakeLocation {
        
        if let cached = quakeCache[url] {
            switch cached {
            case .inProgress(let task):
                return try await task.value
            case .ready(let location):
                return location
            }
        }
        
        let task = Task<QuakeLocation, Error> {
            let data = try await downloader.HTTPData(from: url)
            let location = try decoder.decode(QuakeLocation.self, from: data)
            return location
        }
        
        quakeCache[url] = .inProgress(task)
        do {
            let location = try await task.value
            quakeCache[url] = .ready(location)
            return location
        } catch {
            quakeCache[url] = nil
            throw error
        }
    }
}
