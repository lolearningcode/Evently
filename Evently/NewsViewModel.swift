//
//  EventViewModel.swift
//  Evently
//
//  Created by Cleo Howard on 1/16/22.
//

import SwiftUI

final class EventViewModel: ObservableObject {
    @Published var events: [Events] = []
    
    func getEvents() {
        NetworkManager.shared.getEvents { [unowned self] result in
            
            DispatchQueue.main.async {
                switch result {
                
                case .success(let events):
                    self.events = events
                case .failure(let error):
                    switch error {
                        
                    case .invalidURL:
                        print("URL Failed")
                    case .invalidResponse:
                        print("Response Error")
                    case .decodingData:
                        print("Invalid Data")
                    }
                }
            }
        }
    }
}
