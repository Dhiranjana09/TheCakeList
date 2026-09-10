//
//  ContentView.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var cakes: [Cake] = []
    @State private var errorMessage: String?

    private let cakeService: CakeService = RemoteCakeService()

    var body: some View {
        NavigationStack {
            Group {
                if let errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                } else {
                    List(cakes) { cake in
                        Text(cake.title)
                    }
                }
            }
            .navigationTitle("Cakes")
            .task {
                await loadCakes()
            }
        }
    }

    private func loadCakes() async {
        do {
            cakes = try await cakeService.fetchCakes()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    ContentView()
}
