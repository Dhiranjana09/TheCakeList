//
//  CakeDetailView.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import SwiftUI

struct CakeDetailView: View {
    let cake: Cake
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CakeImage(url: cake.imageURL)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(cake.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .navigationTitle(cake.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(AppStrings.CakeList.closeButtonTitle) {
                        dismiss()
                    }
                }
            }
        }
    }
}
