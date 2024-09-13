//
//  ProductDetailsView.swift
//  PeNaAreia
//
//  Created by Marina Meirelles Paixão on 28/08/24.
//

import SwiftUI
import CloudKit

struct ProductDetailsView: View {
    
    @StateObject var ckModel = CKModel()
    @StateObject var distanceModel = DistanceViewModel()
    @State var order = "asc"
    @State private var searchText = ""
    var foodText: String
    
    
    
    @State private var selectedProductsFilter: ProductsFilter?
    @State private var productTentMapping: [CKRecord.ID: Tents] = [:]
    @State private var tentRelation: Tents?
    
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
                        TextField("Procure por produtos", text: $searchText)
                    }
                    .frame(width: 353, height: 36)
                    .background(Color.searchbar)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    
                }
                .padding(.bottom, 24.0)
                
                HStack {
                    Text(foodText)
                        .font(.system(size: 24))
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.backgroundsand)
                    
                    Spacer()
                    
                    Menu {
                        
                        Picker("teste", selection: $selectedProductsFilter) {
                            ForEach(ProductsFilter.allCases, id: \.self) {
                                productFilter in Text(productFilter.rawValue).tag(productFilter as ProductsFilter?)
                            }
                        }
                    }
                label: { Image(systemName: "line.3.horizontal.decrease.circle")
                        .imageScale(.large)
                        .foregroundStyle(Color.backgroundsand)
                }
                }
                .padding(.horizontal, 19.0)
                VStack {
                    ScrollView {
                        if let location = distanceModel.location{
                            ForEach(ckModel.products.filter({ product in
                                
                                let minusculo = product.name.lowercased()
                                if product.category == foodText && searchText == ""{
                                    return true
                        
                                }
                                else if product.category == foodText && minusculo.contains(searchText.lowercased()){
                                    return true
                                    
                                }
                                else{
                                    return false
                                    
                                }
                                
                            }).sorted(by: { product1, product2 in
                                if (selectedProductsFilter?.rawValue ?? "" == "Preço Baixo"){
                                    product2.price >= product1.price
                                }
                                else{
                                    product2.price <= product1.price
                                }
                            }), id: \.id){ product in
                                ZStack {
                                    Image("bluerectangleproducts")
                                        .resizable()
                                        .frame(width: 350, height: 70)
                                    
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(product.name)
                                                .font(.system(size: 16))
                                                .fontDesign(.rounded)
                                                .fontWeight(.medium)
                                                .foregroundColor(Color.darkblue)
                                            Spacer()
                                            HStack (spacing: 0){
                                                
                                                Text(String(format: "R$%.02f", product.price))
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
                                            
                                            if let tent = productTentMapping[product.id!]{
                                                
                                                let distanceInMeters = tent.coordinates.distance(from: location)
                                                let kilometers = Int(distanceInMeters) / 1000
                                                let meters = Int(distanceInMeters) % 1000
                                                let distance = (kilometers == 0) ? "\(meters)m" : "\(kilometers)km e \(meters)m"
                                                
                                                Text("\(distance) | \(tent.name)")
                                                    .font(.system(size: 14))
                                                    .fontDesign(.rounded)
                                                    .fontWeight(.light)
                                                    .foregroundColor(Color.darkblue)
                                            }
                                            
                                        }
                                    }
                                    .frame(width: 350, height: 50)
                                }
                                .task {
                                    do{
                                        if let fetchTent = try await ckModel.fetchTent(forProduct: product){
                                            DispatchQueue.main.async{
                                                productTentMapping[product.id!] = fetchTent
                                            }
                                        }
                                    }
                                    catch{
                                        print(error)
                                    }
                                }
                                
                            }
                        }
                        else{
                            ForEach(ckModel.products.filter({ product in
                                if product.category == foodText{
                                    return true
                                }
                                else{
                                    return false
                                }
                            }).sorted(by: { product1, product2 in
                                if (selectedProductsFilter?.rawValue ?? "" == "Preço Baixo"){
                                    product2.price >= product1.price
                                }
                                else{
                                    product2.price <= product1.price
                                }
                            }), id: \.id){ product in
                                ZStack {
                                    Image("bluerectangleproducts")
                                        .resizable()
                                        .frame(width: 350, height: 70)
                                    
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(product.name)
                                                .font(.system(size: 16))
                                                .fontDesign(.rounded)
                                                .fontWeight(.medium)
                                                .foregroundColor(Color.darkblue)
                                            Spacer()
                                            HStack (spacing: 0){
                                                
                                                Text(String(format: "R$%.02f", product.price))
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
                                            
                                            if let tent = productTentMapping[product.id!]{
                                                Text("\(tent.name)")
                                                    .font(.system(size: 14))
                                                    .fontDesign(.rounded)
                                                    .fontWeight(.light)
                                                    .foregroundColor(Color.darkblue)
                                            }
                                            
                                        }
                                    }
                                    .frame(width: 350, height: 50)
                                }
                                .task {
                                    do{
                                        if let fetchTent = try await ckModel.fetchTent(forProduct: product){
                                            DispatchQueue.main.async{
                                                productTentMapping[product.id!] = fetchTent
                                            }
                                        }
                                    }
                                    catch{
                                        print(error)
                                    }
                                }
                                
                            }
                        }
                        
                        
                    }
                }
                .task {
                    do{
                        try await ckModel.populateProducts()
                    }
                    catch{
                        print(error)
                    }
                }
            }
            .padding(.top, 70.0)
            
            
            
        }
        
        
        
    }
    
    //    func productFilterFunction(product: Products) -> Bool {
    //        switch selectedProductsFilter {
    //        case .lowPrice:
    //            return product.averagePrice == "Baixo"
    //        case .highPrice:
    //            return product.averagePrice == "Alto"
    //        case nil:
    //            return true
    //        }
    //    }
}

//Lembrar de depois criar o struct que puxa a informação dos produtos


#Preview {
    ProductDetailsView(foodText: "Refrigerantes")
}
