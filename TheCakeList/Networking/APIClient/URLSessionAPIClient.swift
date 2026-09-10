//
//  URLSessionAPIClient.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import Foundation

extension HTTPURLResponse {
    nonisolated var isSuccessful: Bool {
        (200...299).contains(statusCode)
    }
}

nonisolated final class URLSessionAPIClient: APIClient {
    private let session: URLSession
    
    init(
        session: URLSession = .shared,
    ) {
        self.session = session
    }
    
    @concurrent nonisolated
    func send<Response: Decodable & Sendable>(
        _ endpoint: Endpoint,
        responseType: Response.Type
    ) async throws -> Response {
        let request = endpoint.makeRequest()
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIClientError.invalidResponse
            }
            
            guard httpResponse.isSuccessful else {
                throw APIClientError.unsuccessfulStatusCode(
                    httpResponse.statusCode
                )
            }
            
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(Response.self, from: data)
            } catch {
                throw APIClientError.decodingFailed(underlying: error)
            }
        } catch let error as APIClientError {
            throw error
        } catch {
            throw APIClientError.transportFailed(underlying: error)
        }
    }
}
