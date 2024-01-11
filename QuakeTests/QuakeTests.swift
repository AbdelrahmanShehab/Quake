//
//  QuakeTests.swift
//  QuakeTests
//
//  Created by Abdelrahman Shehab on 11/01/2024.
//

import XCTest
@testable import Quake

final class QuakeTests: XCTestCase {

    func testGeoJSONDecoderDecodesQuake() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)
        
        XCTAssertEqual(quake.magnitude, 0.34)
        XCTAssertEqual(quake.place, "5km NW of The Geysers, CA")
        XCTAssertEqual(quake.code, "73649170")
        XCTAssertEqual(quake.detail, "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = quake.time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    }
    
    func testGeoJSONDecoderDecodesGeoJSON() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let decoded = try decoder.decode(GeoJSON.self, from: testQuakesData)
        
        XCTAssertEqual(decoded.quakes.count, 6)
        XCTAssertEqual(decoded.quakes[0].magnitude, 0.34)
        XCTAssertEqual(decoded.quakes[0].place, "5km NW of The Geysers, CA")
        XCTAssertEqual(decoded.quakes[0].code, "73649170")
        XCTAssertEqual(decoded.quakes[0].detail, "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = decoded.quakes[0].time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    }
    
    func testQuakeDetailsDecoder() throws {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(QuakeLocation.self, from: testDetail_hv72783692)
        XCTAssertEqual(decoded.latitude, 19.2189998626709, accuracy: 0.00000000001)
        XCTAssertEqual(decoded.longitude, -155.434173583984, accuracy: 0.00000000001)
    }

}
