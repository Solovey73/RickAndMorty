//
//  NoConnectionView.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 18.07.2024.
//

import SwiftUI

struct NoConnectionView: View {
    let retryAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Image("connection-error-rick-morty (1) 1")
                Text("Network Error")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                   
                Text("There was an error connecting.\n Please check your internet.")
                    .font(.subheadline)
                    .padding(.bottom)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                Button(action: retryAction) {
                    Text("Retry")
                        .frame(width: 200)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .bold()
                }
                Spacer()
                
            }
            .padding()
        }
    }
        
}

struct NoConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        NoConnectionView(retryAction: {})
    }
}
