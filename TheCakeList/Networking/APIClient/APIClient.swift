//
//  APIClient.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import Foundation

nonisolated protocol APIClient: Sendable {
    @concurrent nonisolated
    func send<Response: Decodable & Sendable>(
        _ endpoint: Endpoint,
        responseType: Response.Type
    ) async throws -> Response
}
