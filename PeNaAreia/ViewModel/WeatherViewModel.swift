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
    
    static let location = CLLocation(
        latitude: -8.124624489201008, 
        longitude: -34.8971518
    )
    
    @Published var weather: Weather?
    
    func showWeather() async {
        do {
            print("Tentando carregar o clima para a localização: \(Self.location.coordinate)")
            let weather = try await WeatherService.shared.weather(for: Self.location)
            DispatchQueue.main.async {
                self.weather = weather
                print("Clima carregado com sucesso: \(weather)")
            }
        } catch {
            print("Erro ao carregar o clima: \(error)")
        }
    }
}
