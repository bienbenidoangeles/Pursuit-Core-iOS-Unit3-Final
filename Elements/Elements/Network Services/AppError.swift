//
//  AppError.swift
//  Elements
//
//  Created by Bienbenido Angeles on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

enum AppError: Error{
    case badURL(String)
    case networkClientError(Error)
    case noResponse
    case noData
    case badStatusCode(Int)
    case badMimeType(String)
    case decodingError(Error)
    case encodingError(Error)
}
