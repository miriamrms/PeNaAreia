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
    
    @State private var selectedTentFilter: TentsFilter?
    
    @State var searchText: String = ""
    @State var searchIsActive: Bool = false
    
    var filteredAndSearchTents: [Tents] {
        if selectedTentFilter != nil { //filtrou, depois digitou ou não
            let tentsFiltered = ckModel.tents.filter(componentFilterFunction)
            return !searchText.isEmpty ?
            tentsFiltered.filter({$0.name.contains(searchText)})
            : tentsFiltered
        }
        else { //não colocou o filtro
            return !searchText.isEmpty ?
            ckModel.tents.filter({$0.name.contains(searchText)})
            : ckModel.tents
        }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack {
            HStack{
                SearchBar
                
                
                Menu {
                    //lógica de atualizar tela do filtro
                    Picker("teste", selection: $selectedTentFilter) {
                        ForEach(TentsFilter.allCases, id: \.self) {
                            tentFilter in Text(tentFilter.rawValue).tag(tentFilter as TentsFilter?)
                        }
                    }
                }
            label: { Image(systemName: "line.3.horizontal.decrease.circle")
                    .imageScale(.large)
                    .foregroundStyle(Color.darkerblue)
            }
                
            } .padding(.bottom, 16)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    
                    ForEach(filteredAndSearchTents, id: \.id){ tent in
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
    
    func componentFilterFunction(tent: Tents) -> Bool {
        switch selectedTentFilter {
        case .toilet:
            return tent.toilet
        case .shower:
            return tent.shower
        case .lowPrice:
            return tent.averagePrice == "Baixo"
        case .midPrice:
            return tent.averagePrice == "Médio"
        case .highPrice:
            return tent.averagePrice == "Alto"
        case .lowCapacity:
            return tent.capacity == "Baixa"
        case .midCapacity:
            return tent.capacity == "Média"
        case .highCapacity:
            return tent.capacity == "Alta"
        case .seaBath:
            return tent.seaBath
        case nil:
            return true
        }
    }
    
    private var SearchBar: some View {
        
        // ligada (State/Binding) com a TentViews
        
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 8)
                .foregroundStyle(Color.magnifyingglass)
            TextField("Procure por barracas", text: $searchText)
        }
        .frame(width: 315, height: 36)
        .background(Color.searchbar)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
        
    }
    
    //funcao de busca -> atualizar a tentViews
    
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

#Preview {
    TentsView()
}
