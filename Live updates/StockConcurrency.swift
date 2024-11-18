//
//  StockConcurrency.swift
//  BehaveAI
//
//  Created by Mostafa Mazrouh on 2024-11-18.
//

import Foundation
import AsyncAlgorithms

class StockConcurrency {
    
    private let appleStockObserver = AsyncThrowingChannel<Int, Never>()
    
    private let googleStockObserver = AsyncThrowingChannel<Int, Never>()
    
    let stockObserver = AsyncThrowingChannel<(Int, Int), Never>()
    
    let asyncChannelCurrent = AsyncChannelCurrent<(Int, Int)>(value: (400, 500))
    
    private let sleepDuration: Double = 0.10 // In seconds
    private let stockRange: ClosedRange<Int> = 100...1000
    
    // Randam value every time
    private var newStockPrice: Int {
        Int.random(in: stockRange)
    }
    
    init() {
        Task {
            do {
                try await setup()
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    private func setup() async throws {
        
        try startUpdating()
        
        for try await value in combineLatest(appleStockObserver, googleStockObserver)
            ._throttle(for: .seconds(3), latest: true) {
//            await stockObserver.send(value)
            await asyncChannelCurrent.send(value)
        }
    }
    
    private func startUpdating() throws {
        Task {
            while true {
                try await Task.sleep(for: .seconds(sleepDuration))
                
                await appleStockObserver.send(newStockPrice)
                await googleStockObserver.send(newStockPrice)
                
                try await Task.sleep(for: .seconds(sleepDuration))
                
                await googleStockObserver.send(newStockPrice)
            }
        }
    }
}
