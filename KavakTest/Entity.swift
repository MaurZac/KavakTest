//
//  Entity.swift
//  KavakTest
//
//  Created by Mauricio Zarate on 16/05/22.
//

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let results: Results
}

// MARK: - Results
struct Results: Codable {
    let bestSellers: [String]?
    let books: [Book]?

    enum CodingKeys: String, CodingKey {
        case bestSellers = "best_sellers"
        case books
    }
}

// MARK: - Book
struct Book: Codable {
    let isbn, title, author, bookDescription: String
    let genre: Genre
    let img: String
    let imported: Bool

    enum CodingKeys: String, CodingKey {
        case isbn, title, author
        case bookDescription = "description"
        case genre, img, imported
    }
}

enum Genre: String, Codable {
    case business = "Business"
    case history = "History"
    case science = "Science"
}
