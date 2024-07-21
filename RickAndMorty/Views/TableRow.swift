//
//  TableRow.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 19.07.2024.
//

import SwiftUI

struct TableRow: View {
    let actor: Actor
    let nameSpace: Namespace.ID
    var isSource = false
    var body: some View {
        GroupBox {
            HStack {
                AsyncImage(url: URL(string: actor.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .matchedGeometryEffect(id: "image",
                                               in: nameSpace,
                                               properties: .frame,
                                               anchor: .center,
                                               isSource: false)
                        .animation(.easeIn, value: 5)
                            
                        
                        
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.gray))
                }
                .frame(width: 64, height: 64)
                .cornerRadius(10)
                

                VStack(alignment: .leading) {
                    Text(actor.name)
                        .font(.headline)
                    HStack {
                        Text("\(actor.status.rawValue)")
                            .foregroundColor(colorForStatus(actor.status))
                            .font(.subheadline)
                        Text("• \(actor.species)")
                            .font(.subheadline)
                    }
                    Text(actor.gender.rawValue)
                        .font(.subheadline)
                    
                }

                Spacer()
                
            }
            
            
        }
        .cornerRadius(24)
        .foregroundColor(.primary)
        .padding(.horizontal, 20)
        
    }

    private func colorForStatus(_ status: Status) -> Color {
        switch status {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknown:
            return .primary
        }
    }
    
    mutating func isSourceToggle() {
        isSource.toggle()
    }
}


