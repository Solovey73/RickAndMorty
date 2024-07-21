//
//  NetworkModelManager.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 18.07.2024.
//


import Foundation
import Network

enum NetworkError: Error {
    case noMorePages
    case other(Error)
}

class NetworkModelManager {
    static let shared = NetworkModelManager()
    private let baseURL = "https://rickandmortyapi.com/api"

    func fetchActorList(page: Int, name: String? = nil, status: String? = nil, species: String? = nil, type: String? = nil, gender: String? = nil, completion: @escaping (Result<[Actor], NetworkError>) -> Void) {
        var urlString = "\(baseURL)/character?page=\(page)"
        
        var filters = [String]()
        if let name = name { filters.append("name=\(name)") }
        if let status = status { filters.append("status=\(status)") }
        if let species = species { filters.append("species=\(species)") }
        if let type = type { filters.append("type=\(type)") }
        if let gender = gender { filters.append("gender=\(gender)") }
        
        if !filters.isEmpty {
            urlString += "&" + filters.joined(separator: "&")
        }
        
        guard let url = URL(string: urlString) else { return }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.other(error)))
                return
            }
            
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let errorMessage = json["error"] as? String,
                   errorMessage == "There is nothing here" {
                    completion(.failure(.noMorePages))
                } else {
                    let actorListResponse = try JSONDecoder().decode(ActorListResponse.self, from: data)
                    completion(.success(actorListResponse.results))
                    print("dataSuccess")
                }
            } catch {
                completion(.failure(.other(error)))
                print("dataERROR")
            }
        }.resume()
    }
    
    func fetchActorsDetails(id: Int, completion: @escaping (Result<Actor, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/character/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.other(error)))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let actor = try JSONDecoder().decode(Actor.self, from: data)
                completion(.success(actor))
            } catch {
                completion(.failure(.other(error)))
            }
        }.resume()
    }
}

