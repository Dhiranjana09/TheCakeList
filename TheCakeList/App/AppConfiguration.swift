//
//  AppConfiguration.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//

import Foundation

enum AppConfiguration {
    nonisolated static let cakeListURL: URL = {
        guard
            let urlString = Bundle.main.object(
                forInfoDictionaryKey: "CAKE_API_URL"
            ) as? String,
            let url = URL(string: urlString)
        else {
            preconditionFailure(
                "Missing or invalid CAKE_API_URL configuration."
            )
        }

        return url
    }()
}
