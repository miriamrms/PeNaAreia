//
//  ContentView.swift
//  PeNaAreia
//
//  Created by Miriam Mendes on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                Image("fotoBarracaTemp")
                    .frame(width: 393.0, height: 291.0)
                Spacer()
            }
            .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                Image("BackgroundBarracas")
                    .resizable()
                .scaledToFill()
                .frame(height: 596.0)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            .ignoresSafeArea()
            
        }
    }
}

#Preview {
    ContentView()
}
