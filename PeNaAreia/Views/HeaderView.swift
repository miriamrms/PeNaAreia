//
//  HeaderView.swift
//  PeNaAreia
//
//  Created by Vitória Beltrão Wenceslau do Ó on 27/08/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        
        ZStack{
            Color("backgroundsand")
            VStack {
                Image("headerwaves")
                Image("logo")
                    .padding(.top, 16)
                Text("Ensolarado, 36º | Maré baixa")
                    .foregroundStyle(Color.darkerblue)
                    .font(.system(size: 14, design: .rounded))
                VStack {
                    HStack (spacing: 84) {
                        HStack {
                            Image("umbrellaicon")
                            Text("Barracas")
                                .foregroundStyle(Color.darkblue)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                        }
                        HStack {
                            Image("productsicon")
                            Text("Produtos")
                                .foregroundStyle(Color.darkblue)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                        }
                    } .padding(.top, 32)
                    ZStack {
                        Rectangle()
                            .frame(height: 8)
                            .foregroundStyle(Color.lighterblue)
                        HStack {
                            Rectangle()
                                .frame(width: 196, height: 8)
                                .foregroundStyle(Color.lightblue)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        } .ignoresSafeArea()
        
    }
}

#Preview {
    HeaderView()
}
