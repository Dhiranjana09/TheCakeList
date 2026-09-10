//
//  CakeDetailView.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import SwiftUI

struct CakeDetailView: View {
    let cake: Cake
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(cake.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .navigationTitle(cake.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
