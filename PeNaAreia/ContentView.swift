//
//  ContentView.swift
//  PeNaAreia
//
//  Created by Marina Meirelles Paixão on 30/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var wvm = WeatherViewModel()
    var body: some View {
       HeaderView()
            .environmentObject(wvm)
    }
}

#Preview {
    ContentView()
}
