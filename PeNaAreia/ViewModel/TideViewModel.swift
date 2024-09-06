//
//  TideViewModel.swift
//  PeNaAreia
//
//  Created by Vitória Beltrão Wenceslau do Ó on 29/08/24.
//

import Foundation

struct TideService {
    let apiKey = "0170bd2b-4a1f-427e-884a-927795a64818"
    
    func fetchTideData(lat: Double, lon: Double, radius: Int, completion: @escaping (Result<TideResponse, Error>) -> Void) {
        let urlString = "https://www.worldtides.info/api/v2?heights&lat=-8.124624489201008&&lon=-34.8971518&radius=10&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let tideResponse = try JSONDecoder().decode(TideResponse.self, from: data)
                completion(.success(tideResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    
}
