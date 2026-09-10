//
//  Endpoint.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import Foundation

nonisolated protocol Endpoint: Sendable {
    var url: URL { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    nonisolated func makeRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 15
        request.cachePolicy = .reloadIgnoringLocalCacheData

        return request
    }
}
