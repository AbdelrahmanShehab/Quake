//
//  GeoJSON.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 11/01/2024.
//

import Foundation

struct GeoJSON: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case features
    }
    
    private enum FeatureCodingKeys: String, CodingKey {
        case properties
    }
    
    private(set) var quakes: [Quake] = []
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var featureContainer = try rootContainer.nestedUnkeyedContainer(forKey: .features)
        
        while !featureContainer.isAtEnd {
            let propertiesContainer = try featureContainer.nestedContainer(keyedBy: FeatureCodingKeys.self)
            if let properties = try? propertiesContainer.decode(Quake.self, forKey: .properties) {
                quakes.append(properties)
            }
        }
    }
}
