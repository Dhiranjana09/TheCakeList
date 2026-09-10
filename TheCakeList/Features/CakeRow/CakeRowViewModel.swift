//
//  CakeRowViewModel.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 10/09/2026.
//
import Foundation

struct CakeRowViewModel: Identifiable {
    let cake: Cake
    
    var id: String {
        cake.id
    }
    
    var title: String {
        cake.title
    }
    
    var imageURL: URL? {
        cake.imageURL
    }
}
