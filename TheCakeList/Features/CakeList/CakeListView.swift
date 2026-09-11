//
//  CakeListView.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import SwiftUI

struct CakeListView: View {
    @State private var viewModel: CakeListViewModel
    @State private var selectedCake: Cake?
    
    init(viewModel: @autoclosure @escaping () -> CakeListViewModel) {
        _viewModel = State(wrappedValue: viewModel())
    }
    
    var body: some View {
        NavigationStack {
            content
                .animation(.easeOut(duration: 0.3), value: viewModel.state)
                .navigationTitle(AppStrings.CakeList.navigationTitle)
                .task {
                    if viewModel.state == .idle {
                        await viewModel.loadCakes()
                    }
                }
                .sheet(item: $selectedCake) { cake in
                    CakeDetailView(cake: cake)
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView(AppStrings.CakeList.loadingMessage)
            
        case .loaded(let cakes),
                .refreshing(let cakes),
                .refreshFailed(let cakes, _):
            List(cakes) { cake in
                Button {
                    selectedCake = cake
                } label: {
                    CakeRowView(
                        viewModel: CakeRowViewModel(cake: cake)
                    )
                }
                .buttonStyle(.plain)
                .listRowSeparator(.visible)
            }
            .transition(.opacity.combined(with: .move(edge: .top)))
            .refreshable {
                await viewModel.refreshCakes()
            }.alert(
                AppStrings.CakeList.refreshErrorTitle,
                isPresented: Binding(
                    get: {
                        if case .refreshFailed = viewModel.state {
                            return true
                        }
                        
                        return false
                    },
                    set: { isPresented in
                        if !isPresented {
                            viewModel.dismissRefreshError()
                        }
                    }
                )
            ) {
                Button(AppStrings.CakeList.okButtonTitle, role: .cancel) {
                    viewModel.dismissRefreshError()
                }
            } message: {
                if case let .refreshFailed(_, message) = viewModel.state {
                    Text(message)
                }
            }
            
        case .error(let message):
            VStack(spacing: 16) {
                Text(message)
                    .multilineTextAlignment(.center)
                
                Button(AppStrings.CakeList.retryButtonTitle) {
                    Task {
                        await viewModel.loadCakes()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
