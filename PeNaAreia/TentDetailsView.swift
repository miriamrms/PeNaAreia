//
//  ContentView.swift
//  PeNaAreia
//
//  Created by Miriam Mendes on 26/08/24.
//

import SwiftUI
import CoreLocation

enum StallMenu: String, CaseIterable {
    case comidas = "Comidas"
    case bebidas = "Bebidas"
    
    var images: String {
        switch self {
        case .comidas:
            return "coco.ic"
        case .bebidas:
            return "fish.ic"
        }
    }
}

struct TentDetailsView: View {
    
    let tent: Tents
    let isLocationAutorized: Bool
    let distance: String
    @State private var selectedCategory: StallMenu = .comidas
    
    @AppStorage("favTents") var favTents: [String] = []
    
    var body: some View {
        VStack{
            Image("fotoBarracaTemp")
                .ignoresSafeArea()
            ZStack{
                Image("BackgroundBarracas")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 596.0)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .offset(CGSize(width: 0, height: -52))
                VStack{
                    HStack {
                        Spacer()
                        Button {
                            toggleFav(tent: tent)
                        } label: {
                            ZStack {
                                Image("Vector")
                                    .resizable()
                                    .frame(width: /*@START_MENU_TOKEN@*/45.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/39.0/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                
                                    .padding(.trailing, 27.0)
                                    .padding(.bottom, 8.0)
                                Image(systemName: isFav(tent: tent) ? "heart.fill" : "heart")
                                    .resizable()
                                    .frame(width: /*@START_MENU_TOKEN@*/32.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/27.0/*@END_MENU_TOKEN@*/)
                                    .padding(.trailing, 27.0)
                                    .padding(.bottom, 8.0)
                                    .foregroundColor(isFav(tent: tent) ? .red : .darkerblue)
                            }
                        }
                    }
                    VStack {
                        HStack (alignment: .center) {
                            Text(tent.name)
                                .font(.system(size: 34))
                                .frame(width: 280, alignment: .leading)
                                .fontDesign(.rounded)
                                .fontWeight(.bold)
                                .foregroundColor(Color.darkblue)
                                .padding(.bottom, 4)
                            
                            VStack (spacing:-3){
                                if tent.capacity == "Alta"{
                                    Image("lotacaoAlta.ic")
                                }
                                else if tent.capacity == "Média"{
                                    Image("lotacaoMedia.ic")
                                }
                                else{
                                    Image("lotacaoBaixa.ic")
                                }
                                
                                Text("Lotação há:\n2min")
                                    .font(.system(size: 12))
                                    .fontDesign(.rounded)
                                    .fontWeight(.light)
                                    .foregroundColor(Color.darkblue)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 4)
                            }
                        }
                        
                        HStack{
                            Link(destination: URL(string: tent.linkMap)!) {
                                Image(systemName: "map")
                                Text(isLocationAutorized ? "\(distance) de distância" : "Veja a localização")
                                    .underline()
                                    .font(.system(size: 16))
                                    .fontDesign(.rounded)
                                    .fontWeight(.light)
                                
                            }
                            Spacer()
                        }
                        .padding(.leading)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    } .padding(.bottom, 10)
                    
                    HStack{
                        VStack {
                            HStack {
                                
                                TentTags(icon: tent.shower ? "chuveiro.ic" : "tentnoshower", description: tent.shower ? "Possui chuveiro" : "Sem chuveiro")
                                
                                TentTags(icon: tent.toilet ? "banheiro.ic" : "tentnotoilet", description: tent.toilet ? "Banheiro perto" : "Banheiro longe")
                                
                            }
                            
                            HStack {
                                
                                if tent.averagePrice == "Alto"{
                                    TentTags(icon: "dinheiro.ic", description: "Valores altos")
                                }
                                else if tent.averagePrice == "Médio"{
                                    TentTags(icon: "dinheiro.ic", description: "Valores médios")
                                }
                                else{
                                    TentTags(icon: "dinheiro.ic", description: "Valores baixos")
                                }
                                
                                TentTags(icon: tent.seaBath ? "tentsafeswim" : "riscodebanho.ic", description: tent.seaBath ? "Banho seguro" : "Banho arriscado")
                                
                            }
                            
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 320, height: 8)
                            .foregroundStyle(Color.lighterblue)
                            .offset(y: 30)
                        
                        HStack {
                            ForEach(StallMenu.allCases, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
//                                    ZStack {
//                                        if selectedCategory == category {
//                                            Rectangle()
//                                                .frame(width: 160, height: 8)
//                                                .foregroundStyle(Color.lightblue)
//                                                .clipShape(RoundedRectangle(cornerRadius: 2))
//                                                .offset(x: 23, y: 20)
//                                        }
//                                        
//                                        HStack {
//                                            Image(systemName: category.images)
//                                            Text(category.rawValue)
//                                                .font(.system(size: 20, weight: .semibold, design: .rounded))
//                                        }
//                                        .frame(width: 196)
//                                        .foregroundStyle(selectedCategory == category ? .darkblue : .lightblue)
//                                    }
                                    
                                    
                                }
                            }
                        }
                        .padding(.top, 20)
                    } .frame(width: .infinity)
                    
                    TentProductsListView(tent: tent, masterCategory: selectedCategory.rawValue)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .frame(width: 320)
                .offset(y: -36)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        
    }
    func isFav(tent: Tents) -> Bool {
        return favTents.contains(tent.name)
    }
    func toggleFav(tent: Tents) {
        if let index = favTents.firstIndex(of: tent.name) {
            favTents.remove(at: index)
        } else {
            favTents.append(tent.name)
        }
    }
    
}

struct TentTags: View {
    
    var icon: String
    var description: String
    
    var body: some View {
        
        ZStack {
            
            HStack(spacing: 4) {
                Image("\(icon)")
                Text("\(description)")
                    .font(.system(size: 14))
                    .fontDesign(.rounded)
                    .fontWeight(.regular)
                    .foregroundColor(Color.mediumblue)
                
            }
            
            .frame(width: 144.0, height: 29.0)
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.lighterblue))
            
        }
    }
}

#Preview {
    TentDetailsView(
        tent: Tents(
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
        )
        , isLocationAutorized: true, distance: "54m")
}
