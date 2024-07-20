//
//  CharacterListResponse.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 17.07.2024.
//

import Foundation

// MARK: - CharacterListResponse
struct CharacterListResponse: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Info
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Character: Codable {
    let id: Int // 154
    let name: String // Hamurai
    let status: Status // Dead
    let species: String // Alien
    let type: String? // Parasite
    let gender: Gender // Male
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    case genderless = "Genderless"
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}


