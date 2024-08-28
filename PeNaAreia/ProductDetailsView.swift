//
//  ProductDetailsView.swift
//  PeNaAreia
//
//  Created by Marina Meirelles Paixão on 28/08/24.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @State private var searchText = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Image("productdetailsbackground")
                .resizable()
                .scaledToFill()
            .ignoresSafeArea()
            
            
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(.leading, 8)
                            .foregroundStyle(Color.magnifyingglass)
                        TextField("Procure por barracas", text: $searchText)
                    }
                    .frame(width: 353, height: 36)
                    .background(Color.searchbar)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                   
                }
            
            HStack {
                Text("Batata-frita")
                    .font(.system(size: 24))
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.backgroundsand)
                
                Spacer()
                Image(systemName: "line.3.horizontal.decrease.circle")
                                   .imageScale(.large)
                               .foregroundStyle(Color.backgroundsand)
            }
            .padding(.horizontal, 19.0)
            }
            
            ScrollView {
//                LazyVGrid(columns: columns, spacing: 20) {
//                    ForEach(1...10, id: \.self) { i in
//                        ProductSearch()
            }
        }
        
        
        
    }
}

#Preview {
    ProductDetailsView()
}
