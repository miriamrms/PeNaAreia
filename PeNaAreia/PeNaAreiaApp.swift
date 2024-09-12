//
//  PeNaAreiaApp.swift
//  PeNaAreia
//
//  Created by Miriam Mendes on 26/08/24.
//

import SwiftUI

@main
struct PeNaAreiaApp: App {
    @State private var showAnimatedWave = true // Controla qual view será exibida

    var body: some Scene {
        WindowGroup {
            if showAnimatedWave {
                AnimatedWaveView()
                    .onAppear {
                        // Tempo de transição pra ContentView
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                showAnimatedWave = false
                            }
                        }
                    }
            } else {
                ContentView() // Vai pra ContentView depois que o AnimatedWaveView aparece
            }
        }
    }
}
