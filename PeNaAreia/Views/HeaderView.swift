//
//  HeaderView.swift
//  PeNaAreia
//
//  Created by Vitória Beltrão Wenceslau do Ó on 27/08/24.
//

import SwiftUI

enum Options: String, CaseIterable {
    case stalls = "Barracas"
    case products = "Produtos"
    
    var image: String {
        switch self {
        case .stalls:
            return "beach.umbrella.fill"
        case .products:
            return "takeoutbag.and.cup.and.straw.fill"
            
        }
    }
}

struct HeaderView: View {
    
    @State private var selection: Options = .stalls
    @State private var showProductsView = false
    @Namespace private var namespace
    
    @EnvironmentObject private var wvm: WeatherViewModel
    
    var body: some View {
        
        
        ZStack{
            VStack {
                Image("headerwaves")
                Image("logo")
                    .padding(.top, 16)
                
                if let weather = wvm.weather {
                    
                    Text("\(NSLocalizedString(weather.currentWeather.condition.rawValue, comment: "").capitalized), \(Int(weather.currentWeather.temperature.value))º")
                        .foregroundStyle(Color.darkerblue)
                        .font(.system(size: 14, design: .rounded))
                } else {
                    Text("")
                        .foregroundStyle(Color.darkerblue)
                        .font(.system(size: 14, design: .rounded))
                        .task {
                            print("Executando task para carregar o clima...")
                            await wvm.showWeather()
                            wvm.startAutoUpdate()
                        }
                }
                
                HStack {
                    ForEach(Options.allCases, id: \.self) {option in
                    
                        let isSelected = selection == option
                        
                        Button(action: {
                            selection = option
                            showProductsView = (selection == .products)
                        }) {
                            
                            ZStack {
                                HStack {
                                    Image(systemName: option.image)
                                    Text(option.rawValue)
                                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                                }
                                .frame(width: 196)
                                .foregroundStyle(isSelected ? .darkblue : .lightblue)
                                
                                if isSelected {
                                    Rectangle()
                                        .frame(width: 196, height: 8)
                                        .foregroundStyle(Color.lightblue)
                                        .clipShape(RoundedRectangle(cornerRadius: 2))
                                        .offset(y: 20)
                                        .matchedGeometryEffect(id: "selection", in: namespace)
                                }
                            }
                            
                        }
                        
                    }
                } .background(
                Rectangle()
                    .frame(height: 8)
                    .foregroundStyle(Color.lighterblue)
                    .offset(y: 20)
                
                )
                .padding(.top, 12)
                .animation(.smooth, value: selection)
                
                
                Spacer()
            }
        } .ignoresSafeArea()
            .frame(height: 274)
        
        if showProductsView {
            ProductsView()
                .padding(.top, -30)
        } else {
            TentsView()
                .padding(.top, -20)
        }
        
        Spacer()
          
    }
}


#Preview {
    HeaderView()
        .environmentObject(WeatherViewModel())
}
