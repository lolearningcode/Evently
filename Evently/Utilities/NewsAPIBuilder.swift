//
//  NewsAPIBuilder.swift
//  Evently
//
//  Created by Cleo Howard on 1/17/22.
//

import Foundation

//created protocol for reusability
protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseURL: URL { get }
    var path: String { get }
}

enum APIEndpoints {
    case getNewsArticles
    case getWeather
}

extension APIEndpoints: APIBuilder {
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseURL.appendingPathComponent(path))
    }
    
    var baseURL: URL {
        switch self {
        case .getNewsArticles, .getWeather:
            return URL(string: "https://api.lil.software/") ?? URL(fileURLWithPath: "")
        }
    }
    var path: String {
        switch self {
        case .getNewsArticles:
            return "news"
        case .getWeather:
            return "weather?latitude=36.1699&longitude=-115.1398"
        }
    }
}
