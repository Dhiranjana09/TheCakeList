//
//  StubAPIClient.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import Foundation
@testable import TheCakeList

final class StubAPIClient: APIClient {
    typealias Handler = @Sendable (any Endpoint, Any.Type) throws -> any Sendable
    
    private let handler: Handler
    private let callCounter = CallCounter()
    
    init(handler: @escaping Handler) {
        self.handler = handler
    }
    
    @concurrent nonisolated
    func send<Response: Decodable & Sendable>(
        _ endpoint: any Endpoint,
        responseType: Response.Type
    ) async throws -> Response {
        await callCounter.increment()
        
        let value = try handler(endpoint, Response.self)
        
        guard let response = value as? Response else {
            fatalError("Stub response does not match requested type.")
        }
        
        return response
    }
    
    func sendCallCount() async -> Int {
        await callCounter.value()
    }
}
