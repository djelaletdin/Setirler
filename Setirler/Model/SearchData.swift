//
//  SearchData.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/05/29.
//

import Foundation

struct SearchRawData: Codable {
    let status: Int
    let data: [SearchRawDatum]
}

// MARK: - Datum
struct SearchRawDatum: Codable {
    let categoryName: String
    let peomData: [SearchDatum]

    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case peomData = "peom_data"
    }
}

// MARK: - PeomDatum
struct SearchDatum: Codable {
    let id: Int
    let content: String
}

