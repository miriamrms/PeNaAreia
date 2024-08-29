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
                    Image("back.ic")
                        .padding(.leading, 25.0)
                    Spacer()
                }
                .padding(.bottom, 44.0)
                
                
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
                .padding(.bottom, 24.0)
                
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
                VStack {
                    ScrollView {
                        ZStack {
                            Image("bluerectangleproducts")
                                .resizable()
                            .frame(width: 350, height: 70)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Nome da Barraca")
                                        .font(.system(size: 16))
                                        .fontDesign(.rounded)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.darkblue)
                                    Spacer()
                                    HStack (spacing: 0){
                                        Text("R$:")
                                            .font(.system(size: 14))
                                            .fontDesign(.rounded)
                                            .fontWeight(.regular)
                                        .foregroundColor(Color.darkblue)
                                        
                                        Text("00,00")
                                            .font(.system(size: 14))
                                            .fontDesign(.rounded)
                                            .fontWeight(.medium)
                                        .foregroundColor(Color.darkblue)
                                    }
                                }
                                .frame(width: 305
                                )
                                
                                HStack (spacing: 0){
                                    Image(systemName: "mappin")
                                        .foregroundColor(Color.darkblue)
                                    
                                    Text("Distância da Barraca")
                                        .font(.system(size: 14))
                                        .fontDesign(.rounded)
                                        .fontWeight(.light)
                                        .foregroundColor(Color.darkblue)
                                }
                            }
                            .frame(width: 350, height: 50)
                        }
                        
                        ZStack {
                            Image("sandrectangleproducts")
                                .resizable()
                            .frame(width: 350, height: 70)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Nome da Barraca")
                                        .font(.system(size: 16))
                                        .fontDesign(.rounded)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.darkblue)
                                    Spacer()
                                    HStack (spacing: 0){
                                        Text("R$:")
                                            .font(.system(size: 14))
                                            .fontDesign(.rounded)
                                            .fontWeight(.regular)
                                        .foregroundColor(Color.darkblue)
                                        
                                        Text("00,00")
                                            .font(.system(size: 14))
                                            .fontDesign(.rounded)
                                            .fontWeight(.medium)
                                        .foregroundColor(Color.darkblue)
                                    }
                                }
                                .frame(width: 305
                                )
                                
                                HStack (spacing: 0){
                                    Image(systemName: "mappin")
                                        .foregroundColor(Color.darkblue)
                                    
                                    Text("Distância da Barraca")
                                        .font(.system(size: 14))
                                        .fontDesign(.rounded)
                                        .fontWeight(.light)
                                        .foregroundColor(Color.darkblue)
                                }
                            }
                            .frame(width: 350, height: 50)
                        }
                    }
                }
            }
            .padding(.top, 40.0)
            
            

        }
        
        
        
    }
}




#Preview {
    ProductDetailsView()
}
