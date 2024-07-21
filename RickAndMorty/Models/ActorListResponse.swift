//
//  ActorListResponse.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 17.07.2024.
//

import Foundation

struct ActorListResponse: Codable {
    let info: Info
    let results: [Actor]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Actor: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String?
    let gender: Gender
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

struct Location: Codable {
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}


