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
            CakeImage(url: viewModel.imageURL)
            .frame(width: 72, height: 72)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(viewModel.title)
                .font(.headline)
                .foregroundStyle(.primary)
        }
        .padding(.vertical, 4)
    }
}
