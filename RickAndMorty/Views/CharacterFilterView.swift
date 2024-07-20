//
//  CharacterFilterView.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 19.07.2024.
//

import SwiftUI

struct CharacterFilterView: View {
    @ObservedObject var viewModel: CharacterListViewModel

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.characters, id: \.id) { character in
                    NavigationLink(destination: CharacterDetailView(characterId: character.id)) {
                        TableRow(character: character)
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if viewModel.noMorePages {
                    Text("Это конец")
                        .padding()
                }
            }
        }
        .navigationTitle("Filtered Characters")
        .onAppear {
            if viewModel.characters.isEmpty {
                viewModel.fetchCharacters(reset: true)
            }
        }
    }
}
