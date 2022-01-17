//
//  NewsViewModel.swift
//  Evently
//
//  Created by Cleo Howard on 1/16/22.
//

import Combine

protocol NewsViewModel {
    func getNewsArticles()
    func getWeather()
}

final class NewsViewModelImpl: ObservableObject, NewsViewModel {
    
    private let newsService: NewsService
    
    @Published var articles: [Article] = []
    @Published var forecast: [Forecast] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func getNewsArticles() {
        isLoading = true
        
        let cancellable = newsService
            .request(from: .getNewsArticles)
            .sink { [self] result in
                switch result {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .decodingData:
                        alertItem = AlertContext.invalidData
                    }
                }
            } receiveValue: { response in
                self.articles = response.articles
            }
        
        self.cancellables.insert(cancellable)
    }
    
    func getWeather() {
        self.isLoading = true
        
        let cancellable = newsService
            .requestWeather(from: .getNewsArticles)
            .sink { [self] result in
                switch result {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .decodingData:
                        alertItem = AlertContext.invalidData
                    }
                }
            } receiveValue: { response in
                self.forecast = response.forecast
            }
        self.cancellables.insert(cancellable)
    }
    
}
