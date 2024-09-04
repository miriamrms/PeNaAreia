//
//  TentsView.swift
//  PeNaAreia
//
//  Created by Vitória Beltrão Wenceslau do Ó on 27/08/24.
//

import SwiftUI
import CoreLocation

struct TentsView: View {
    @StateObject var ckModel = CKModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack{
            HStack{
                SearchBar(widthBar: 315, searchPrompt: "Procure por barracas")
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .imageScale(.large)
                    .foregroundStyle(Color.darkerblue)
            } .padding(.bottom, 16)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
//                    NavigationStack{
//                        ForEach(ckModel.tents, id: \.id){ tent in
//                            TentCard(tent: tent)
//                        }
//                        .navigationDestination(for: tents) { name in
//                            TentDetailsView(tent: name)
//                        }
//                    }
                    ForEach(ckModel.tents, id: \.id){ tent in
                        NavigationLink(destination: TentDetailsView(tent: tent)){
                            TentCard(tent: tent)
                        }
                    }
                    
                } .padding(0)
            }
        } 
        .background(Color.backgroundsand)
        .frame(width: 354)
        .task {
            do{
                try await ckModel.populateTents()
            }
            catch{
                print(error)
            }
        }
    }
}

struct TentCard: View {
    
    let tent: Tents
    
    var body: some View {
        ZStack{
            
            Image(tent.image)
                .resizable()
                .scaledToFill()
            LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
            
            VStack (alignment: .leading) {
                
                Spacer()
                
                Text(tent.name)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                
                Text("200m de distância")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 12, weight: .light, design: .rounded))
                
                
                HStack {
                    Image(tent.shower ? "shower" : "noShower")
                    Image(tent.toilet ? "toilet" : "noToilet")
                    Image(tent.seaBath ? "swim" : "noSwim")
                    
                    Spacer()
                    
                    HStack (spacing: -2){
                        Image(systemName: "person.fill")
                            .foregroundStyle(Color.white)
                        Image(systemName: "person.fill")
                            .foregroundStyle((tent.capacity == "Baixa") ? Color.magnifyingglass : Color.white)
                        Image(systemName: "person.fill")
                            .foregroundStyle((tent.capacity == "Alta") ? Color.white : Color.magnifyingglass)
                    }
                    .imageScale(.small)
                } .padding(.bottom, 8)
                    .padding(.top, 2)
                
            } .frame(width: 152)
            
        } .frame(width: 169, height: 184)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
    }
}


struct TentsIcons: View {
    var iconName: String
    var body: some View {
        
        Image(systemName: "\(iconName)")
            .foregroundStyle(Color.white)
            .imageScale(.small)
    }
}

struct SearchBar: View {
    
    @State private var searchText = ""
    var widthBar: CGFloat
    var searchPrompt: String
    
    var body: some View {
        
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 8)
                .foregroundStyle(Color.magnifyingglass)
            TextField("\(searchPrompt)", text: $searchText)
        }
        .frame(width: widthBar, height: 36)
        .background(Color.searchbar)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
        
    }
}

#Preview {
    TentsView()
}
