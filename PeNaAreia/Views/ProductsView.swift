//
//  ProductsView.swift
//  PeNaAreia
//
//  Created by Vitória Beltrão Wenceslau do Ó on 28/08/24.
//

import SwiftUI

struct ProductsView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
            ScrollView {
                
                VStack (alignment: .leading)  {
                    
                    ProductTitle(title: "Alimentos")
                        .padding(.bottom, 20)
                        .padding(.top, -4)
                    
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        NavigationLink(destination: ProductDetailsView(foodText: "Batatas fritas")) {
                                      ProductItem(backgroundImage: "productsand", foodImage: "batatas_fritas", foodText: "Batatas fritas", offset: -10)
                                    }
                        NavigationLink(destination: ProductDetailsView(foodText: "Espetinhos")) {
                          ProductItem(backgroundImage: "productblue", foodImage: "espetinhos", foodText: "Espetinhos", offset: -14)
                        }
                        NavigationLink(destination: ProductDetailsView(foodText: "Caldinhos")) {
                          ProductItem(backgroundImage: "productblue", foodImage: "caldinhos", foodText: "Caldinhos", offset: -19)
                        }
                        NavigationLink(destination: ProductDetailsView(foodText: "Peixes e Frutos do Mar")) {
                          ProductItem(backgroundImage: "productsand", foodImage: "shrimp", foodText: "Peixes e Frutos do Mar", offset: -19)
                        }
                        NavigationLink(destination: ProductDetailsView(foodText: "Almoços")) {
                            ProductItem(backgroundImage: "productsand", foodImage: "lunch", foodText: "Almoços", offset: -13)
                        }
                        NavigationLink(destination: ProductDetailsView(foodText: "Lanches")) {
                          ProductItem(backgroundImage: "productblue", foodImage: "hamburguer", foodText: "Lanches", offset: -14)
                        }            
                        
                    }
                    
                    ProductTitle(title: "Bebidas")
                        .padding(.bottom, 20)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        NavigationLink(destination: ProductDetailsView(foodText: "Águas")) {
                            ProductItem(backgroundImage: "productsand", foodImage: "aguas", foodText: "Águas", offset: -26)
                        }
                        NavigationLink(destination: ProductDetailsView(foodText: "Sucos")) {
                            ProductItem(backgroundImage: "productblue", foodImage: "sucos", foodText: "Sucos", offset: -20)
                        }
                        NavigationLink(destination: ProductDetailsView(foodText: "Refrigerantes")) {
                            ProductItem(backgroundImage: "productblue", foodImage: "refrigerantes", foodText: "Refrigerantes", offset: -10)
                        }
                        NavigationLink(destination: ProductDetailsView(foodText: "Cervejas")) {
                            ProductItem(backgroundImage: "productsand", foodImage: "cervejas", foodText: "Cervejas", offset: -19)
                        }
                        NavigationLink(destination: ProductDetailsView(foodText: "Drinks")) {
                            ProductItem(backgroundImage: "productsand", foodImage: "drinks", foodText: "Drinks", offset: -20)
                        }
                        NavigationLink(destination: ProductDetailsView(foodText: "Cachaças")) {
                            ProductItem(backgroundImage: "productblue", foodImage: "cachacas", foodText: "Cachaças", offset: -26)
                        }
                        
                    }
                }
            }  .background(Color.backgroundsand)
            .frame(width: 350)
    }
}

struct ProductTitle: View {
    
    var title: String
    
    var body: some View {
        
        Text("\(title)")
            .foregroundStyle(Color.darkblue)
            .font(.system(size: 24, weight: .semibold, design: .rounded))
            .padding(.top, 24)
        
    }
}

struct ProductItem: View {
    
    var backgroundImage: String
    var foodImage: String
    var foodText: String
    var offset: CGFloat
    
    var body: some View {
        
        VStack (alignment: .leading){
            
            ZStack {
                Image("\(backgroundImage)")
                Image("\(foodImage)")
                    .offset(y: offset)
            }
            
            Text("\(foodText)")
                .foregroundStyle(Color.darkerblue)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .padding(.top, 8)
            
        } .frame(width: 141, height: 116)
    }
}

#Preview {
    ProductsView()
}
