//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 18.07.2024.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject private var viewModel = CharacterDetailViewModel()
    let characterId: Int
    let nameSpace: Namespace.ID
    @State var isSource = true
    var body: some View {
        VStack {
            if let character = viewModel.character {
                VStack {
                    AsyncImage(url: URL(string: character.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.gray))
                    }
                    .frame(width: 320, height: 320)
                    .cornerRadius(10)
                    .padding(.top, 20)
                    .matchedGeometryEffect(id: "imag",
                                           in: nameSpace,
                                           properties: .frame,
                                           anchor: .top,
                                           isSource: isSource)
                    .refreshable {
                        isSource.toggle()
                    }
                    statusView(for: character.status)
                        .frame(width: 320, height: 42)
                        .cornerRadius(5)
                        .padding(.top, 10)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Species: ").bold() + Text(character.species)
                        Text("Gender: ").bold() + Text(character.gender.rawValue)
                        Text("Episodes: ").bold() +  Text(episodeNumbers(from: character.episode))
                        Text("Last known location: ").bold() + Text(character.location.name)
                        
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                }
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding()
            } else if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                Text("Failed to load character details: \(error.localizedDescription)")
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.character?.name ?? "Character Details")
                    .font(.system(size: 24))
                    .bold()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchCharacterDetails(id: characterId)
        }
        .matchedGeometryEffect(id: "image", in: nameSpace)
    }
    
    private func statusView(for status: Status) -> some View {
        Text(status.rawValue)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colorForStatus(status))
            .cornerRadius(10)
    }
    
    private func colorForStatus(_ status: Status) -> Color {
        switch status {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknown:
            return .gray
        }
    }
    private func episodeNumbers(from urls: [String]) -> String {
            return urls.compactMap { url in
                URL(string: url)?.lastPathComponent
            }.joined(separator: ", ")
        }
}

struct CharacterDetailViewPreviews: PreviewProvider {
    @Namespace static var nameSpace
    static var previews: some View {
        CharacterDetailView(characterId: 1, nameSpace: nameSpace)
    }
}








