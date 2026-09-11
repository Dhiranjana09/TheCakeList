//
//  CakeRowView.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import SwiftUI

struct CakeRowView: View {
    let cake: Cake
    
    var body: some View {
        HStack(spacing: 12) {
            CakeImage(url: cake.imageURL)
            .frame(width: 72, height: 72)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(cake.title)
                .font(.headline)
                .foregroundStyle(.primary)
        }
        .padding(.vertical, 4)
    }
}
