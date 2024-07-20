//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 17.07.2024.
//

import SwiftUI

@main
struct RickAndMortiApp: App {
    var body: some Scene {
        WindowGroup {
            CharacterListView()
                .preferredColorScheme(.dark)
        }
    }
}
