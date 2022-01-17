//
//  NetworkManager.swift
//  Evently
//
//  Created by Cleo Howard on 1/16/22.
//

import Foundation
import UIKit
import Combine

protocol APIService {
    func request(from endpoint: APIEndpoints) -> AnyPublisher<NewsResponse, APIError>
    func requestWeather(from endPoint: APIEndpoints) -> AnyPublisher<WeatherResponse, APIError>
}

struct NewsService: APIService {
    
    func request(from endpoint: APIEndpoints) -> AnyPublisher<NewsResponse, APIError> {
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.invalidURL }
            .flatMap { data, response -> AnyPublisher<NewsResponse, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.invalidResponse).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    return Just(data)
                        .decode(type: NewsResponse.self, decoder: decoder)
                        .mapError { _ in APIError.decodingData }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.invalidResponse).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func requestWeather(from endPoint: APIEndpoints) -> AnyPublisher<WeatherResponse, APIError> {
        return URLSession.shared
            .dataTaskPublisher(for: endPoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.invalidURL }
            .flatMap { data, response -> AnyPublisher<WeatherResponse, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.invalidResponse).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    return Just(data)
                        .decode(type: WeatherResponse.self, decoder: decoder)
                        .mapError { _ in APIError.decodingData }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.invalidResponse).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
