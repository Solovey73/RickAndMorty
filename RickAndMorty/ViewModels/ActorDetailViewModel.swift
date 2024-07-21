//
//  ActorDetailViewModel.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 17.07.2024.
//

import Foundation
import Combine

class ActorDetailViewModel: ObservableObject {
    @Published var actor: Actor?
    @Published var isLoading = false
    @Published var error: Error?

    private var cancellables = Set<AnyCancellable>()

    func fetchActorDetails(id: Int) {
        isLoading = true
        NetworkModelManager.shared.fetchActorsDetails(id: id) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let actor):
                    self?.actor = actor
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}
