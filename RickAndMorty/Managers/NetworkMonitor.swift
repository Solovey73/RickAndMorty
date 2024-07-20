//
//  NetworkMonitor.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 18.07.2024.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected: Bool = true
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    func checkConnection() {
        isConnected = monitor.currentPath.status == .satisfied
        print(isConnected)
    }
}
