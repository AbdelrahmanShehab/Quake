//
//  QuakeLocation.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 11/01/2024.
//

import Foundation

struct QuakeLocation: Decodable {
    
    private var properties: RootProperties
    
    var latitude: Double { properties.products.origin.first!.properties.latitude }
    var longitude: Double { properties.products.origin.first!.properties.longitude }
    
    struct RootProperties: Decodable {
        var products: Products
    }
    struct Products: Decodable {
        var origin: [Origin]
    }
    struct Origin: Decodable {
        var properties: OriginProperties
    }
    struct OriginProperties {
        var latitude: Double
        var longitude: Double
    }
}

extension QuakeLocation.OriginProperties: Decodable {
    
    private enum OriginPropertiesKodingKeys: String, CodingKey {
        case longitude
        case latitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OriginPropertiesKodingKeys.self)
        let longitude = try container.decode(String.self, forKey: .longitude)
        let latitude = try container.decode(String.self, forKey: .latitude)
        
        guard let longitude = Double(longitude),
              let latitude = Double(latitude)
        else { throw QuakeError.missingData }
        
        self.longitude = longitude
        self.latitude = latitude
    }
}
