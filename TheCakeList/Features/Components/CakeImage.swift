//
//  CakeImageView.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 11/09/2026.
//

import SwiftUI

struct CakeImage: View {
    let url: URL?
    let placeholderFont: Font = .title2
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .empty:
                ProgressView()
                
            default:
                Image(systemName: "photo")
                    .font(placeholderFont)
                    .foregroundStyle(.secondary)
                    .accessibilityLabel(AppStrings.CakeList.ImageUnavailableLabel)
            }
        }
        .background(Color.secondary.opacity(0.12))
    }
}
