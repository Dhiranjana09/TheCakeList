//
//  CallCounter.swift
//  TheCakeList
//
//  Created by Dhiranjana Yadav on 11/09/2026.
//


actor CallCounter {
    private var count = 0

    func increment() { count += 1 }
    func value() -> Int { count }
}
