//
//  CategoryRawData.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/25.
//

import Foundation

// MARK: - WelcomeElement
struct CategoryRawData: Codable {
    let status: Int
    var data: [CategoryData]
    let lastPage, perPage, total: Int

    enum CodingKeys: String, CodingKey {
        case status, data
        case lastPage = "last_page"
        case perPage = "per_page"
        case total
    }
}

// MARK: - Datum
struct CategoryData: Codable {
    let id: Int
    let name, photo: String
    let poemCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name, photo
        case poemCount = "poem_count"
    }
}
