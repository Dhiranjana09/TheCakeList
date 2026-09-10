//
//  APIClientError.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import Foundation

nonisolated enum APIClientError: Error, Sendable {
    case invalidResponse
    case unsuccessfulStatusCode(Int)
    case decodingFailed(underlying: Error)
    case transportFailed(underlying: Error)
}
