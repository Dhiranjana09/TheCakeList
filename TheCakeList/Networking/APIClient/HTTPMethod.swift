//
//  HTTPMethod.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import Foundation

nonisolated enum HTTPMethod: String, Sendable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
