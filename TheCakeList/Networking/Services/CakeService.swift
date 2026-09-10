//
//  CakeService.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import Foundation

nonisolated protocol CakeService: Sendable {
    @concurrent nonisolated
    func fetchCakes() async throws -> [Cake]
}
