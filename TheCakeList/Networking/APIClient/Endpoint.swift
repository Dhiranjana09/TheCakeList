//
//  Endpoint.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import Foundation

nonisolated protocol Endpoint: Sendable {
    var path: String { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    nonisolated func makeRequest(baseURL: URL) -> URLRequest {
        var request = URLRequest(url: baseURL.appending(path: path))
        request.httpMethod = method.rawValue
        
        return request
    }
}
