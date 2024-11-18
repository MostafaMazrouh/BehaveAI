//
//  LiveUpdatesVM.swift
//  BehaveAI
//
//  Created by Mostafa Mazrouh on 2024-11-17.
//

import Foundation
import Combine


class LiveUpdatesVM: ObservableObject {
    
    
    
    @Published var combineInsight = ""
    @Published var combineCurrent = ""
    
    @Published var concurrencyInsight = ""
    @Published var concurrencyCurrent = ""
    
    let stockCombine = StockCombine()
    let stockConcurrency = StockConcurrency()
    
    func updateCombineCurrent() {
        combineCurrent = "(\(stockCombine.stockObserver.value.0), \(stockCombine.stockObserver.value.1))"
    }
    
    @MainActor
    func updateConcurrencyCurrent() {
        Task {
            concurrencyCurrent = """
(\( await stockConcurrency.asyncChannelCurrent.getCurrentValue().0),\(
    await stockConcurrency.asyncChannelCurrent.getCurrentValue().1))
"""
            
//        stockConcurrency.stockObserver.value
        }
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        startInsights()
    }
    
    func startInsights() {
        startCombine()
        
        Task {
            try await startConcurrency()
        }
    }
    
    func startCombine() {
        stockCombine.stockObserver.sink { [weak self] (appleStock, googleStock) in
            self?.combineInsight = """
                                Apple Stock **\(appleStock)**
                                
                                Google Stock **\(googleStock)**
                                """
        }
        .store(in: &cancellables)
    }
    
    @MainActor
    func startConcurrency() async throws {
        for try await (appleStock, googleStock) in await stockConcurrency.asyncChannelCurrent.channel {
            concurrencyInsight = """
                                Apple Stock **\(appleStock)**
                                
                                Google Stock **\(googleStock)**
                                """
        }
    }
}
