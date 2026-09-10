//
//  RemoteCakeServiceTests.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import XCTest
@testable import TheCakeList

final class RemoteCakeServiceTests: XCTestCase {
    @MainActor
    func testFetchCakes_whenAPIClientSucceeds_returnsCakes() async throws {
        // Given
        let expectedCakes = [
            Cake(
                title: "Chocolate Cake",
                description: "Rich chocolate sponge.",
                imageURLString: "https://example.com/chocolate.jpg"
            )
        ]
        
        let apiClient = StubAPIClient { _, responseType in
            guard responseType == [Cake].self else {
                throw TestError.unexpectedResponseType
            }
            
            return expectedCakes
        }
        
        let sut = RemoteCakeService(apiClient: apiClient)
        
        // When
        let cakes = try await sut.fetchCakes()
        
        // Then
        XCTAssertEqual(cakes, expectedCakes)
        let count = await apiClient.sendCallCount()
        XCTAssertEqual(count, 1)
    }
    
    @MainActor
    func testFetchCakes_whenAPIClientFails_forwardsError() async {
        // Given
        let apiClient = StubAPIClient { _, _ in
            throw TestError.expected
        }
        
        let sut = RemoteCakeService(apiClient: apiClient)
        
        // When / Then
        do {
            _ = try await sut.fetchCakes()
            XCTFail("Expected fetchCakes to throw an error.")
        } catch {
            XCTAssertEqual(error as? TestError, .expected)
            let count = await apiClient.sendCallCount()
            XCTAssertEqual(count, 1)
        }
    }
}
