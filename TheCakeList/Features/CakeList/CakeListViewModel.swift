//
//  CakeListViewState.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import Foundation
import Observation

enum CakeListViewState: Equatable {
    case idle
    case loading
    case loaded([Cake])
    case refreshing([Cake])
    case refreshFailed(cakes: [Cake], message: String)
    case error(String)
}

@Observable
final class CakeListViewModel {
    private(set) var state: CakeListViewState = .idle
    
    @ObservationIgnored private let cakeService: CakeService
    
    init(cakeService: CakeService) {
        self.cakeService = cakeService
    }
    
    func loadCakes() async {
        state = .loading
        
        do {
            let cakes = try await cakeService.fetchCakes()
            state = .loaded(process(cakes))
        } catch {
            state = .error(AppStrings.CakeList.loadErrorMessage)
        }
    }
    
    func refreshCakes() async {
        let existingCakes: [Cake]
        
        switch state {
        case .loaded(let cakes),
                .refreshFailed(let cakes, _):
            existingCakes = cakes
            
        default:
            await loadCakes()
            return
        }
        
        state = .refreshing(existingCakes)
        
        do {
            let cakes = try await cakeService.fetchCakes()
            state = .loaded(process(cakes))
        } catch {
            state = .refreshFailed(
                cakes: existingCakes,
                message: AppStrings.CakeList.loadErrorMessage
            )
        }
    }
    
    func dismissRefreshError() {
        guard case let .refreshFailed(cakes, _) = state else {
            return
        }
        
        state = .loaded(cakes)
    }
    
    private func process(_ cakes: [Cake]) -> [Cake] {
        Array(Set(cakes))
            .sorted {
                $0.title.localizedCaseInsensitiveCompare($1.title)
                == .orderedAscending
            }
    }
}
