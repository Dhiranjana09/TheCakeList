//
//  RemoteCakeService.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import Foundation

nonisolated final class RemoteCakeService: CakeService {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    @concurrent nonisolated
    func fetchCakes() async throws -> [Cake] {
        try await apiClient.send(CakeListEndpoint(), responseType: [Cake].self)
    }
}
