//
//  TentProductsListView.swift
//  PeNaAreia
//
//  Created by Miriam Mendes on 11/09/24.
//

import SwiftUI
import CoreLocation

struct TentProductsListView: View {
    @StateObject var ckModel = CKModel()
    var tent: Tents
    var masterCategory: String
    
    var body: some View {
        List {
            ForEach(ckModel.products.filter({ product in
                if getMasterCategory(product: product) == masterCategory{
                    return true
                }
                else{
                    return false
                }
            }), id: \.id){ product in
                HStack{
                    VStack(alignment: .leading){
                        Text(product.name)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                        Text(product.serving)
                            .font(.system(size: 14))
                    }
                    Spacer()
                    Text(String(format: "R$%.02f", product.price))
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                }
                .fontDesign(.rounded)
                .foregroundColor(Color.darkblue)
            }
        }
        .listStyle(PlainListStyle())
        .task {
            do{
                try await ckModel.populateTentProducts(forTent: tent)
            }
            catch{
                print(error)
            }
        }
    }
}

#Preview {
    TentProductsListView(tent: Tents(
        id: nil,
        name: "Nome",
        image: "Nome",
        linkMap: "Nome",
        coordinates: CLLocation(latitude: -4, longitude: -4),
        seaBath: true,
        shower: false,
        toilet: false,
        averagePrice: "3",
        capacity: "Média"
    ), masterCategory: "Bebidas")
}
