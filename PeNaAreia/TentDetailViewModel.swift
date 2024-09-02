//
//  TentDetailViewModel.swift
//  PeNaAreia
//
//  Created by Caio Silva on 30/08/24.
//

import Foundation
import SwiftUI

class TentDetailsViewModel: ObservableObject {
    
    @AppStorage("savedItems") var savedItemsData: String = ""
    @Published var items: [String] = []
    
    func addItem(_ newItem: String) {
        items.append(newItem)
        saveItems()
    }
    
    func loadItems() {
        if let data = savedItemsData.data(using: .utf8),
           let decodedItems = try? JSONDecoder().decode([String].self, from: data) {
            items = decodedItems
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            savedItemsData = String(data: encodedData, encoding: .utf8) ?? ""
        }
    }
    
}
