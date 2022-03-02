//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Jae Young Choi on 3/1/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() { }

    let imageCache = NSCache<NSString, NSData>()

    func fetchPokemonList(completion: @escaping (Result<Response, Error>) -> Void) {
        let baseURL = "https://pokeapi.co/api/v2/pokemon?limit=151/"
        let url = URL(string: baseURL)!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(Result.failure(error))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(error!))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(error))
                }
            }
        }.resume()
    }
}
