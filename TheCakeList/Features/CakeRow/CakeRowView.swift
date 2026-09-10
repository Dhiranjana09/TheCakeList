//
//  CakeRowView.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import SwiftUI

struct CakeRowView: View {
    let viewModel: CakeRowViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: viewModel.imageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                default:
                    Image(systemName: "photo")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: 72, height: 72)
            .background(Color.secondary.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(viewModel.title)
                .font(.headline)
                .foregroundStyle(.primary)
        }
        .padding(.vertical, 4)
    }
}
