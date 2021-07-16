//
//  RawData.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 01.04.2021.
//

import Foundation


// MARK: - OrderRawData
struct OrderRawData: Codable {
    let status: Int?
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let categoryName: String?
    let categoryContent: [CategoryContent]?

    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case categoryContent = "category_content"
    }
}

// MARK: - CategoryContent
struct CategoryContent: Codable {
    let id: Int?
    let name, categoryContentDescription: String?
    let poemCount: Int?
    let photo: String?
    let view, poetID: Int?
    let poet: String?
    let sentence: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case categoryContentDescription = "description"
        case poemCount = "poem_count"
        case photo, view
        case poetID = "poet_id"
        case poet
        case sentence
    }
}
