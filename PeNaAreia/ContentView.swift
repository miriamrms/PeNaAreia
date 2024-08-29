//
//  ContentView.swift
//  PeNaAreia
//
//  Created by Miriam Mendes on 26/08/24.
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
