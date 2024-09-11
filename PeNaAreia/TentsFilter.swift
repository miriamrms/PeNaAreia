//
//  TentsFilter.swift
//  PeNaAreia
//
//  Created by Caio Silva on 06/09/24.
//

import Foundation

enum TentsFilter: String, CaseIterable {
    
    case favorite = "Favorito"
    case toilet = "Banheiro"
    case shower = "Chuveiro"
    case seaBath = "Banho de Mar"
    case lowPrice = "Preço Baixo"
    case midPrice = "Preço Médio"
    case highPrice = "Preço Alto"
    case lowCapacity = "Baixa Lotação"
    case midCapacity = "Média Lotação"
    case highCapacity = "Alta Lotação"
}
