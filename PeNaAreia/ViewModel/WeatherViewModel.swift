//
//  WeatherViewModel.swift
//  PeNaAreia
//
//  Created by Vitória Beltrão Wenceslau do Ó on 29/08/24.
//


import Foundation
import CoreLocation
import WeatherKit


class WeatherViewModel: ObservableObject {
    
    let location = CLLocation(
        latitude: -8.124624489201008,
        longitude: -34.8971518
    )
    
    @Published var weather: Weather?
    @Published var tideStatus: String = "..."
    
    @MainActor
    func showWeather() async {
        do {
            weather = try await Task {
                try await WeatherService.shared.weather(for: location)
            }.value
        } catch {
            print("Erro ao carregar o clima: \(error.localizedDescription)")
        }
    }
    
    
    func startAutoUpdate() {
            Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { _ in
                Task {
                    await self.showWeather()
                }
            }
        }
    
}
