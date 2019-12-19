//
//  ElementsModel.swift
//  Elements
//
//  Created by Bienbenido Angeles on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Decodable{
    let name: String
    let symbol: String
    let number: Int
    let atomicMass: Double
    let melt: Int
    let boil: Int
    let discoveredBy: String
    private enum CodingKeys: String, CodingKey{
        case name
        case symbol
        case number
        case atomicMass = "atomic_mass"
        case melt
        case boil
        case discoveredBy = "discovered_by"
    }
}
