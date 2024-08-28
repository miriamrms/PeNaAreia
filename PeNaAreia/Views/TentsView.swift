//
//  TentsView.swift
//  PeNaAreia
//
//  Created by Vitória Beltrão Wenceslau do Ó on 27/08/24.
//

import SwiftUI

struct TentsView: View {
    
    @State private var searchText = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading, 8)
                        .foregroundStyle(Color.magnifyingglass)
                    TextField("Procure por barracas", text: $searchText)
                }
                .frame(width: 315, height: 36)
                .background(Color.searchbar)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .imageScale(.large)
                    .foregroundStyle(Color.darkerblue)
            } .padding(.top, 332)
            
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(1...10, id: \.self) { i in
                    TentCard()
                }
            } .padding()
        }
    }
}


struct TentCard: View {
    var body: some View {
        ZStack{
            
            Image("tentpreview")
                .resizable()
                .scaledToFill()
            LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
            
            VStack (alignment: .leading) {
                
                Spacer()
                
                Text("Barraca do Tio")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                
                Text("200m de distância")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 12, weight: .light, design: .rounded))
                
                
                HStack {
                    
                    iconsTents(iconName: "shower.fill")
                    iconsTents(iconName: "toilet.fill")
                    iconsTents(iconName: "figure.open.water.swim")
                    
                    Spacer()
                    
                    HStack (spacing: -2){
                        
                        iconsTents(iconName: "person.fill")
                        iconsTents(iconName: "person.fill")
                        iconsTents(iconName: "person.fill")
                        
                    }
                } .padding(.bottom, 8)
                    .padding(.top, 2)
                
            } .frame(width: 152)
            
        } .frame(width: 169, height: 184)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
    }
}

struct iconsTents: View {
    
    var iconName: String

    var body: some View {
      
        Image(systemName: "\(iconName)")
            .foregroundStyle(Color.white)
            .imageScale(.small)
        
    }
}

#Preview {
    TentsView()
}
