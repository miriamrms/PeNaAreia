//
//  ContentView.swift
//  PeNaAreia
//
//  Created by Miriam Mendes on 26/08/24.
//

import SwiftUI
import CoreLocation

struct TentDetailsView: View {

    let tent: Tents
    let isLocationAutorized: Bool
    let distance: String

    @AppStorage("favTents") var favTents: [String] = []
    
    var body: some View {
        ZStack {
            ZStack {
                Color("backgroundsand")
                
                ZStack {
                    VStack {
                        Image("fotoBarracaTemp")
                            .frame(width: 393.0, height: 291.0)
                        Spacer()
                    }
                    
                    VStack {
                        HStack {
                            Image("back.ic")
                                .padding(.leading, 25.0)
                                .padding(.top, 40.0)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .edgesIgnoringSafeArea(.top)
                
                
                VStack(alignment: .center) {
                    Spacer()
                    ZStack {
                        Image("BackgroundBarracas")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 596.0)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        //MARK: - Infos Barraca
                        //Tudo abaixo da imagem da barraca
                        VStack {
                            
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
                                        
                                        Text("Lotação há 2min")
                                            .font(.system(size: 12))
                                            .fontDesign(.rounded)
                                            .fontWeight(.light)
                                            .foregroundColor(Color.darkblue)
                                    }
                                }
                                
                                //localização
                                HStack {
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
                            //MARK: - Segmented control
                            VStack {
                                HStack (spacing: 84) {
                                    HStack(alignment: .top) {
                                        Image("fish.ic")
                                        
                                        Text("Comidas")
                                            .foregroundStyle(Color.darkerblue)
                                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    }
                                    HStack(alignment: .top) {
                                        Image("coco.ic")
                                            .resizable()
                                            .frame(width: 14.0, height: 20.0)
                                        
                                        Text("Bebidas")
                                            .foregroundStyle(Color.darkerblue)
                                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    }
                                } .padding(.top, 30)
                                
                                ZStack {
                                    Rectangle()
                                        .frame(height: 4)
                                        .foregroundStyle(Color.lighterblue)
                                    HStack {
                                        Rectangle()
                                            .frame(width: 179, height: 4)
                                            .foregroundStyle(Color.darkblue)
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.horizontal, 22.0)
                            Spacer()
                                .frame(height: 294.0)
                        }
                        
                        
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        
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
