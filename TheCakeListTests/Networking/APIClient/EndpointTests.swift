//
//  EndpointTests.swift
//  TheCakeListTests
//
//  Created by Dhiranjana Yadav on 11/09/2026.
//
import XCTest
@testable import TheCakeList

final class EndpointTests: XCTestCase {
    private let baseURL = URL(string: "https://example.com/api")!

    func testMakeRequest_fullPath() {
        let request = StubEndpoint().makeRequest(baseURL: baseURL)
        
        XCTAssertEqual(request.url?.absoluteString, "https://example.com/api/cakes")
        XCTAssertEqual(request.httpMethod, "GET")
    }
    
    func testMakeRequest_NoQueryAndHeader() {
        let request = StubEndpoint().makeRequest(baseURL: baseURL)
        
        XCTAssertNil(request.url?.query)
        XCTAssertNil(request.value(forHTTPHeaderField: "Accept"))
    }
    
    func testMakeRequest_WithQueryAndHeader() {
        let request = StubEndpoint(
            queryItems: [URLQueryItem(name: "q", value: "chocolate")],
            headers: ["Accept": "application/json"]
        ).makeRequest(baseURL: baseURL)
        
        XCTAssertEqual(request.url?.absoluteString, "https://example.com/api/cakes?q=chocolate")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"), "application/json")
    }


}
