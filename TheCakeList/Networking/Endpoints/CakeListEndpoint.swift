//
//  CakeListEndpoint.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import Foundation

nonisolated struct CakeListEndpoint: Endpoint {
    let path: String = "cakes"
    let method = HTTPMethod.get
}
