//
//  PoemListData.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/22.
//

import Foundation

// MARK: - Welcome
struct PoemListRawData: Codable {
    let status: Int
    var data: [PoemListContent]
    let lastPage, perPage, total: Int

    enum CodingKeys: String, CodingKey {
        case status, data
        case lastPage = "last_page"
        case perPage = "per_page"
        case total
    }
}

// MARK: - Datum
struct PoemListContent: Codable {
    let id: Int
    let name, sentence: String
    let poetName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case poetName = "poet_name"
        case name, sentence
    }
}

