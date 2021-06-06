//
//  SearchData.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/05/29.
//

import Foundation

// MARK: - Welcome
struct SearchRawData: Codable {
    let status: Int
    let data: [SearchDatum]
}

// MARK: - Datum
struct SearchDatum: Codable {
    let id, poetID: Int
    let name, content: String
    let view: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case poetID = "poet_id"
        case name, content, view
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
