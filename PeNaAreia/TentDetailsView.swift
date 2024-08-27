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
            ZStack {
                Color("backgroundsand")
                
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
            VStack {
                Image("back.ic")
                
                Image("like.ic")
                
                HStack {
                    Text("Nome da Barraca")
                        .font(.system(size: 34))
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .foregroundColor(Color.darkblue)
                    
                    VStack {
                        Image("lotacaoBaixa.ic")
                        
                        Text("Lotação há 2min")
                            .font(.system(size: 12))
                            .fontDesign(.rounded)
                            .fontWeight(.light)
                            .foregroundColor(Color.darkblue)
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
