//
//  ActorFilterView.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 19.07.2024.
//

import SwiftUI

struct ActorFilterView: View {
    @ObservedObject var viewModel: ActorListViewModel
    @Namespace var nameSpace

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.actors, id: \.id) { actor in
                    NavigationLink(destination: ActorDetailView(actorId: actor.id, nameSpace: nameSpace)) {
                        TableRow(actor: actor, nameSpace: nameSpace)
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
            if viewModel.actors.isEmpty {
                viewModel.fetchActors(reset: true)
            }
        }
        .scrollIndicatorsFlash(onAppear: true)
    }
}
