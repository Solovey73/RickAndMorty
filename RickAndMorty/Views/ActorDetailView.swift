//
//  ActorDetailView.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 18.07.2024.
//

import SwiftUI

struct ActorDetailView: View {
    @StateObject private var viewModel = ActorDetailViewModel()
    let actorId: Int
    let nameSpace: Namespace.ID
    @State var isSource = true
    var body: some View {
        VStack {
            if let actor = viewModel.actor {
                VStack {
                    AsyncImage(url: URL(string: actor.image)) { image in
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
                    statusView(for: actor.status)
                        .frame(width: 320, height: 42)
                        .cornerRadius(5)
                        .padding(.top, 10)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Species: ").bold() + Text(actor.species)
                        Text("Gender: ").bold() + Text(actor.gender.rawValue)
                        Text("Episodes: ").bold() +  Text(episodeNumbers(from: actor.episode))
                        Text("Last known location: ").bold() + Text(actor.location.name)
                        
                        
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
                Text("Failed to load actor details: \(error.localizedDescription)")
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.actor?.name ?? "Actor Details")
                    .font(.system(size: 24))
                    .bold()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchActorDetails(id: actorId)
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

struct ActorDetailViewPreviews: PreviewProvider {
    @Namespace static var nameSpace
    static var previews: some View {
        ActorDetailView(actorId: 1, nameSpace: nameSpace)
    }
}








