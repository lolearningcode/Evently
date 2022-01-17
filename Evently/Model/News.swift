//
//  News.swift
//  Evently
//
//  Created by Cleo Howard on 1/15/22.
//

import Foundation
import UIKit

struct ArticlesResponse: Codable {
    let articles: [Article]
}

// MARK: - Article
struct Article: Identifiable, Codable {
    let id = UUID()
    let author: String
    let url: String
    let source, title, articleDescription: String
    let image: String
    let date: Date

    enum CodingKeys: String, CodingKey {
        case author, url, source, title
        case articleDescription = "description"
        case image, date
    }
}
