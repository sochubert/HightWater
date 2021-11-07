//
//  Flood.swift
//  HighWaters
//
//  Created by Minjae Lee on 2021/11/07.
//

import Foundation

struct Flood {
    var latitude: Double
    var longitude: Double
    
    func toDictionary() -> [String: Any] {
        return ["latitude": self.latitude, "longitude": self.longitude]
    }
}
