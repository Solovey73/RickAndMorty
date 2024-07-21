//
//  ActorListViewModel.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 18.07.2024.
//

import Combine
import SwiftUI

class ActorListViewModel: ObservableObject {
    @Published var actors = [Actor]()
    @Published var isLoading = false
    @Published var noMorePages = false
    @Published var isConnected = true
    private var currentPage = 1
    
    
    @Published var searchName: String? = nil
    @Published var status: String? = nil
    @Published var species: String? = nil
    @Published var type: String? = nil
    @Published var gender: String? = nil

    func fetchActors(reset: Bool = false) {
        if reset {
            currentPage = 1
            actors.removeAll()
            noMorePages = false
        }
        
        guard !isLoading && !noMorePages else { return }
        
        isLoading = true
        
        NetworkModelManager.shared.fetchActorList(
            page: currentPage,
            name: searchName,
            status: status,
            species: species,
            type: type,
            gender: gender
        ) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let newActors):
                    self.actors.append(contentsOf: newActors)
                    print(self.actors.capacity)
                    self.isConnected = true
                    if newActors.isEmpty {
                        self.noMorePages = true
                    } else {
                        self.currentPage += 1
                    }
                case .failure(let error):
                    switch error {
                    case .noMorePages:
                        self.noMorePages = true
                    case .other(let error):
                        self.isConnected = false
                        print("Error fetching actors: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func search() {
        fetchActors(reset: true)
    }
}

