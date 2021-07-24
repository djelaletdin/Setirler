//
//  PoemData.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/06/09.
//


import Foundation

// MARK: - Welcome
struct PoemRawData: Codable {
    let status: Int
    let data: PoemData
}

// MARK: - PoemDataClass
struct PoemData: Codable {
    let id, poetID: Int
    let name, content: String
    let view: Int
    let poetName, poetImage: String
    let poemCount: Int
    let tags: [Tag]

    enum CodingKeys: String, CodingKey {
        case id
         case poetID = "poet_id"
         case name, content, view
         case poetName = "poet_name"
         case poetImage = "poet_image"
         case poemCount = "poem_count"
         case tags
    }
}

// MARK: - Tag
struct Tag: Codable {
    let id: Int
    let name, tagDescription: String
    let poemCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case tagDescription = "description"
        case poemCount = "poem_count"
    }
}
