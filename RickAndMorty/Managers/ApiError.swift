//
//  ApiError.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 18.07.2024.
//

import Foundation

enum ApiError: Error {
    case error
    case noData
    case urlNotValidate
    case decodingError
    case encodingEror
}
