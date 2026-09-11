//
//  TheCakeListApp.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//

import SwiftUI

@main
struct TheCakeListApp: App {
    private let cakeService: CakeService
    
    init() {
        guard let baseURL = AppConfiguration.apiBaseURL() else {
            preconditionFailure(
                "Missing or invalid API_BASE_URL configuration."
            )
        }
        
        /*
         TODO: Currently Request policy is configured once at the composition root.
         With several endpoints needing different policies,
         I'd introduce a Request Policy value owned by the client, with optional per-end override.
        */
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let apiClient = URLSessionAPIClient(baseURL: baseURL, session: URLSession(configuration: configuration))
        cakeService = RemoteCakeService(apiClient: apiClient)
    }

    var body: some Scene {
        WindowGroup {
            CakeListView(viewModel: CakeListViewModel(cakeService: cakeService))
        }
    }
}
