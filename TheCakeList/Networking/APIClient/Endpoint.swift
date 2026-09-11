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
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
}

extension Endpoint {
    nonisolated var queryItems: [URLQueryItem] { [] }
    nonisolated var headers: [String: String] { [:] }
    
    nonisolated func makeRequest(baseURL: URL) -> URLRequest {
        var url = baseURL.appending(path: path)
        
        if !queryItems.isEmpty {
            url = url.appending(queryItems: queryItems)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        for (field, value) in headers {
            request.setValue(value, forHTTPHeaderField: field)
        }
        
        return request
    }
}
