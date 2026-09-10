//
//  Cake.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//

import Foundation

nonisolated struct Cake: Codable, Equatable, Hashable, Identifiable, Sendable {
    let title: String
    let description: String
    let imageURLString: String

    var id: String {
        "\(title)|\(description)|\(imageURLString)"
    }

    var imageURL: URL? {
        URL(string: imageURLString)
    }

    private enum CodingKeys: String, CodingKey {
        case title
        case description = "desc"
        case imageURLString = "image"
    }
}
