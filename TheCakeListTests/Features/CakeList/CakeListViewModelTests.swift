//
//  CakeListViewModelTests.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import XCTest
@testable import TheCakeList

@MainActor
final class CakeListViewModelTests: XCTestCase {
    func testLoadCakes_whenServiceSucceeds_removesDuplicatesAndSorts() async {
        // Given
        let chocolateCake = makeCake(
            title: "Chocolate Cake"
        )
        
        let appleCake = makeCake(
            title: "Apple Cake"
        )
        
        let service = StubCakeService(
            result: .success([
                chocolateCake,
                appleCake,
                chocolateCake
            ])
        )
        
        let sut = CakeListViewModel(cakeService: service)
        
        // When
        await sut.loadCakes()
        
        // Then
        XCTAssertEqual(
            sut.state,
            .loaded([appleCake, chocolateCake])
        )
        let count = await service.fetchCallCount()
        XCTAssertEqual(count, 1)
    }
    
    func testLoadCakes_whenServiceFails_showsErrorState() async {
        // Given
        let service = StubCakeService(
            result:
                    .failure(TestError.expected)
        )
        
        let sut = CakeListViewModel(cakeService: service)
        
        // When
        await sut.loadCakes()
        
        // Then
        XCTAssertEqual(
            sut.state,
            .error(AppStrings.CakeList.loadErrorMessage)
        )
        let count = await service.fetchCallCount()
        XCTAssertEqual(count, 1)
    }
    
    func testRefreshCakes_whenServiceSucceeds_replacesCakes() async {
        // Given
        let initialCake = makeCake(
            title: "Chocolate Cake"
        )
        
        let refreshedCake = makeCake(
            title: "Lemon Drizzle"
        )
        
        let service = StubCakeService(
            result: .success([initialCake]),
        )
        
        let sut = CakeListViewModel(cakeService: service)
        
        await sut.loadCakes()
        
        // When
        await service.updateResult(.success([refreshedCake]))
        await sut.refreshCakes()
        
        // Then
        XCTAssertEqual(
            sut.state,
            .loaded([refreshedCake])
        )
        let count = await service.fetchCallCount()
        XCTAssertEqual(count, 2)
    }
    
    func testRefreshCakes_whenServiceFails_keepsExistingCakesAndShowsError() async {
        // Given
        let initialCake = makeCake(
            title: "Chocolate Cake"
        )
        
        let service = StubCakeService(
            result: .success([initialCake])
        )
        
        let sut = CakeListViewModel(cakeService: service)
        
        await sut.loadCakes()
        
        // When
        await service.updateResult( .failure(TestError.expected))
        await sut.refreshCakes()
        
        // Then
        XCTAssertEqual(
            sut.state,
            .refreshFailed(
                cakes: [initialCake],
                message: AppStrings.CakeList.loadErrorMessage
            )
        )
        let count = await service.fetchCallCount()
        XCTAssertEqual(count, 2)
    }
    
    private func makeCake(title: String) -> Cake {
        Cake(
            title: title,
            description: "\(title) description.",
            imageURLString: "https://example.com/\(title).jpg"
        )
    }
}
