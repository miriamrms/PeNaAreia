//
//  HeaderView.swift
//  PeNaAreia
//
//  Created by Vitória Beltrão Wenceslau do Ó on 27/08/24.
//

import SwiftUI

struct HeaderView: View {
    
    @State private var showProductsView = false
    @EnvironmentObject private var wvm: WeatherViewModel
    
    var body: some View {
        
        ZStack{
            
            Color("backgroundsand")
            
            VStack {
                
                Image("headerwaves")
                Image("logo")
                    .padding(.top, 16)
                
                if let weather = wvm.weather {
                    Text("\(NSLocalizedString(weather.currentWeather.condition.rawValue, comment: "").capitalized), \(Int(weather.currentWeather.temperature.value))º  |  \(wvm.tideStatus)")
                        .foregroundStyle(Color.darkerblue)
                        .font(.system(size: 14, design: .rounded))
                } else {
                    Text("...")
                        .foregroundStyle(Color.darkerblue)
                        .font(.system(size: 14, design: .rounded))
                        .task {
                            print("Executando task para carregar o clima...")
                            await wvm.showWeather()
                            wvm.fetchTide()
                            wvm.startAutoUpdate()
                        }
                }
                
                HStack (spacing: 84) {
                    Button(action: { showProductsView = false
                    }, label: {
                        HStack {
                            Image("umbrellaicon")
                            Text("Barracas")
                                .foregroundStyle(Color.darkblue)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                        }
                    })
                    
                    Button(action: { showProductsView = true
                    }, label: {
                        HStack {
                            Image("productsicon")
                            Text("Produtos")
                                .foregroundStyle(Color.darkblue)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                        }
                    })
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
                Spacer()
            }
        } .ignoresSafeArea()
            .frame(height: 274)
        
        if showProductsView {
            ProductsView()
        } else {
            TentsView()
        }
    }
}

#Preview {
    HeaderView()
        .environmentObject(WeatherViewModel())
}
