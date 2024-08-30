//
//  TideModel.swift
//  PeNaAreia
//
//  Created by Vitória Beltrão Wenceslau do Ó on 29/08/24.
//

import Foundation

struct TideResponse: Codable {
    let heights: [TideData]
}

struct TideData: Codable {
    let height: Double
    let date: String
}
