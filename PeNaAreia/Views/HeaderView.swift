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
    @State private var selected: String = "Barracas"
    
    var body: some View {
        
        ZStack{
            
            Color("backgroundsand")
            
            VStack {
                Image("headerwaves")
                Image("logo")
                    .padding(.top, 16)
                
                if let weather = wvm.weather {
//                    Text("\(NSLocalizedString(weather.currentWeather.condition.rawValue, comment: "").capitalized), \(Int(weather.currentWeather.temperature.value))º  |  \(wvm.tideStatus)")
                    Text("\(NSLocalizedString(weather.currentWeather.condition.rawValue, comment: "").capitalized), \(Int(weather.currentWeather.temperature.value))º")
                        .foregroundStyle(Color.darkerblue)
                        .font(.system(size: 14, design: .rounded))
                } else {
                    Text("...")
                        .foregroundStyle(Color.darkerblue)
                        .font(.system(size: 14, design: .rounded))
                        .task {
                            print("Executando task para carregar o clima...")
                            await wvm.showWeather()
//                            wvm.fetchTide()
                            wvm.startAutoUpdate()
                        }
                }
               
                MainSegmentedControlView(selection: $selected)
                    .padding(.top, 24)
//
                Spacer()
            }
        } .ignoresSafeArea()
            .frame(height: 274)
        if selected == "Produtos" {
            ProductsView()
        } else {
            TentsView()
        }
    }
}

struct MainSegmentedControlView: View{
    var options: [String] = ["Barracas","Produtos"]
    @Binding var selection: String
    @Namespace private var namespace
    var body: some View{
        HStack(alignment: .top, spacing: 0){
            ForEach(options, id: \.self){ option in
                VStack{
                    HStack{
                        Image(option == "Produtos" ? "productsicon" : "umbrellaicon")
                        Text(option)
                            .foregroundStyle(Color.darkblue)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    ZStack{
                        Rectangle()
                            .frame(height: 8)
                            .foregroundStyle(Color.lighterblue)
                        if selection == option{
                            Rectangle()
                                .frame(height: 8)
                                .foregroundStyle(Color.lightblue)
                                .matchedGeometryEffect(id: "selection", in: namespace)
                        }
                    }
                
                }
                .foregroundStyle(selection == option ? .darkblue : .lightblue)
                .onTapGesture {
                    selection = option
                }
                
            }
        }
        .animation(.smooth, value: selection)
    }
}

#Preview {
    HeaderView()
        .environmentObject(WeatherViewModel())
}
