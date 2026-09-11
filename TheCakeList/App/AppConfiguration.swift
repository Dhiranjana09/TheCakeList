//
//  AppConfiguration.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//

import Foundation

enum AppConfiguration {
    nonisolated static func apiBaseURL(bundle: Bundle = .main) -> URL? {
        guard
            let urlString = bundle.object(forInfoDictionaryKey: "API_BASE_URL") as? String,
            let url = URL(string: urlString)
        else { return nil }
        return url
    }
}
