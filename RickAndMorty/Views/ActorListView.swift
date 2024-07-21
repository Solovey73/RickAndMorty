//
//  ActorListView.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 18.07.2024.
//

import SwiftUI

struct ActorListView: View {
    @StateObject private var viewModel = ActorListViewModel()
    
    @State private var searchText: String = ""
    @State private var selectedStatus: String? = nil
    @State private var selectedSpecies: String? = nil
    @State private var selectedType: String? = nil
    @State private var selectedGender: String? = nil
    
    @State private var showingSettings = false
    
    @Namespace var nameSpace
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isConnected {
                    HStack {
                        TextField("\( Image(systemName: "magnifyingglass"))Search", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .onChange(of: searchText) { newValue in
                                viewModel.searchName = newValue.isEmpty ? nil : newValue
                                viewModel.search()
                            }
                        
                        Button(action: {
                            showingSettings.toggle()
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                                       
                        }
                        .padding(.trailing)
                    }
                    if viewModel.actors.isEmpty && !viewModel.isLoading {
                                                  Image("Group 2")
                                                  .resizable()
                                                  .scaledToFit()
                                                      .padding()
                                              
                                          }
                    ScrollView {
                        LazyVStack {
                                ForEach(viewModel.actors, id: \.id) { actor in
                                    NavigationLink(destination: ActorDetailView(actorId: actor.id, nameSpace: nameSpace)) {
                                        TableRow(actor: actor, nameSpace: nameSpace)
                                            
                                    }
                                    .scrollTransition { content, phase in
                                                    content
                                                        .opacity(phase.isIdentity ? 1 : 0)
                                                        .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                                        .blur(radius: phase.isIdentity ? 0 : 10)
                                                }
                                    
                                }
                                
                                if viewModel.isLoading {
                                    ProgressView()
                                        .padding()
                                } else if viewModel.noMorePages && !viewModel.actors.isEmpty {
                                    Text("No more actors")
                                        .padding()
                                } else {
                                    Color.clear
                                        .onAppear {
                                            viewModel.fetchActors()
                                        }
                                }
                        
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                                               Text("Rick & Morty Characters")
                                                   .font(.system(size: 20, weight: .bold))
                                           }
                                       }
                    .onAppear {
                        if viewModel.actors.isEmpty {
                            viewModel.fetchActors()
                        }
                    }
                    .scrollIndicatorsFlash(onAppear: true)
                } else {
                    ErrorView {
                        viewModel.fetchActors()
                    }
                }
            }
            .padding(.top,0)
            .sheet(isPresented: $showingSettings) {
                FilterSettingsView(
                    viewModel: viewModel,
                    selectedStatus: $selectedStatus,
                    selectedGender: $selectedGender
                )
                .presentationDetents([.medium])
            }
        }
    }
}

struct ActorListView_Previews: PreviewProvider {
    static var previews: some View {
        ActorListView()
    }
}
