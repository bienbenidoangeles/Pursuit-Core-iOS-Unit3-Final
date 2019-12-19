//
//  ElementsModel.swift
//  Elements
//
//  Created by Bienbenido Angeles on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct AtomicElement: Codable{
    let name: String
    let symbol: String
    let number: Int
    let atomicMass: Double
    let melt: IntOrDouble?
    let boil: IntOrDouble?
    let discoveredBy: String?
    let favoritedBy: String?
    private enum CodingKeys: String, CodingKey, Codable{
        case name
        case symbol
        case number
        case atomicMass = "atomic_mass"
        case melt
        case boil
        case discoveredBy = "discovered_by"
        case favoritedBy
    }
}

enum IntOrDouble:Codable, CustomStringConvertible{
    
    case int(Int)
    case double(Double)
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch  self {
        case .double(let x):
            try container.encode(x)
        case .int(let y):
            try container.encode(y)
            throw AppError.missingValue
        }
    }
    init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self){
            self = .int(intValue)
            return
        }
        if let doubleValue = try? decoder.singleValueContainer().decode(Double.self){
            self = .double(doubleValue)
            return
        }
        
        throw AppError.missingValue
    }
    
    var description: String{
        switch  self {
        case .double(let x):
            return String(x)
        case .int(let y):
            return String(y)
        }
    }
}
