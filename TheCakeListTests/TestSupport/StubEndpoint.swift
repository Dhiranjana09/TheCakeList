//
//  StubEndpoint.swift
//  TheCakeListTests
//
//  Created by Dhiranjana Yadav on 11/09/2026.
//
import Foundation
@testable import TheCakeList

nonisolated struct StubEndpoint: Endpoint {
    var path: String = "cakes"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem] = []
    var headers: [String : String] = [:]
}
