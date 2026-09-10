//
//  FakeCakeService.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
@testable import TheCakeList

nonisolated final class StubCakeService: CakeService {
    typealias ServiceResult = Result<[Cake], any Error & Sendable>

    private let state: State

    init(result: ServiceResult) {
        state = State(result: result)
    }

    @concurrent nonisolated
    func fetchCakes() async throws -> [Cake] {
        try await state.fetchCakes()
    }

    func updateResult(_ result: ServiceResult) async {
        await state.update(result)
    }

    func fetchCallCount() async -> Int {
        await state.fetchCallCount()
    }

    private actor State {
        private var result: ServiceResult
        private var count = 0

        init(result: ServiceResult) {
            self.result = result
        }

        func fetchCakes() throws -> [Cake] {
            count += 1
            return try result.get()
        }

        func update(_ result: ServiceResult) {
            self.result = result
        }

        func fetchCallCount() -> Int {
            count
        }
    }
}
