//
//  CacheEntryObject.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 20/01/2024.
//

import Foundation

final class CacheEntryObject{
    let entry: CacheEntry
    init(entry: CacheEntry) {
        self.entry = entry
    }
}

enum CacheEntry {
    case inProgress(Task<QuakeLocation, Error>)
    case ready(QuakeLocation)
}
