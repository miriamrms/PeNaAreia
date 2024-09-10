//
//  ProductDetailsView.swift
//  PeNaAreia
//
//  Created by Marina Meirelles Paixão on 28/08/24.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @StateObject var ckModel = CKModel()
    @State var order = "asc"
    @State private var searchText = ""
    var foodText: String
    
    @State private var selectedProductsFilter: ProductsFilter?
    
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
                        //ForEach(ckModel.products.sorted(by: { product1, product2 in
                          //  if (selectedProductsFilter?.rawValue ?? "" == "Preço Baixo") {
                            //    product1.price >= product2.price
                            //} else {
                              //  product1.price <= product2.price
                        ForEach(ckModel.products.filter({ product in
                            if product.category == foodText{
                                return true
                            }
                            else{
                                return false
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
                                        
                                        Text("200m | ")
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
                .task {
                    do{
                        try await ckModel.populateProducts()
                    }
                    catch{
                        print(error)
                    }
                }
            }
            .padding(.top, 40.0)
            
            

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
    ProductDetailsView(foodText: "Batata-Frita")
}
