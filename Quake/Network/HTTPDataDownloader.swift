//
//  HTTPDataDownloader.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 11/01/2024.
//

import Foundation

protocol HTTPDataDownloader {
    func HTTPData(from url: URL) async throws -> Data
}

let validStatus = 200...299

extension URLSession: HTTPDataDownloader {
    func HTTPData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse), validStatus.contains(response.statusCode) else {
            throw QuakeError.missingData
        }
        return data
    }
    
    
}
