//
//  ResultsState.swift
//  Evently
//
//  Created by Cleo Howard on 1/17/22.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Article])
    case failed(error: Error)
}
