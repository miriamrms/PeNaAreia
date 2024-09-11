//
//  CategoryViewModel.swift
//  PeNaAreia
//
//  Created by Miriam Mendes on 11/09/24.
//

import Foundation

enum Category: String{
    case comidas = "Comidas"
    case bebidas = "Bebidas"
}

func getMasterCategory(product: Products) -> String{
    if product.category == "Batatas fritas" || product.category == "Espetinhos" || product.category == "Caldinhos" || product.category == "Peixes e frutos do mar" || product.category == "Almoços" || product.category == "Lanches"{
        return Category.comidas.rawValue
    }
    else{
        return Category.bebidas.rawValue
    }
}

