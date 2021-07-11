//
//  SearchData.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/05/29.
//

import Foundation

struct SearchRawData: Codable {
    let status: Int
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let poemNames: [PoemName]
    let poemSentences: [PoemSentence]

    enum CodingKeys: String, CodingKey {
        case poemNames = "poem_names"
        case poemSentences = "poem_sentences"
    }
}

// MARK: - PoemName
struct PoemName: Codable {
    let id: Int
    let autohor, content: String
}

// MARK: - PoemSentence
struct PoemSentence: Codable {
    let id: Int
    let content: String
}
