//
//  StockCombine.swift
//  BehaveAI
//
//  Created by Mostafa Mazrouh on 2024-11-18.
//

import Foundation
import Combine

class StockCombine {
    
    private let appleStockObserver = CurrentValueSubject<Int, Never>(400)
    private let googleStockObserver = CurrentValueSubject<Int, Never>(500)
    
    var stockObserver = CurrentValueSubject<(Int, Int), Never>((400, 500))
    
    private var cancellables = Set<AnyCancellable>()
    
    private let sleepDuration: Double = 0.10 // In seconds
    private let stockRange: ClosedRange<Int> = 100...1000
    
    // Randam value every time
    private var newStockPrice: Int {
        Int.random(in: stockRange)
    }
    
    
    init() {
        setup()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: startUpdating)
    }
    
    func setup() {
        Publishers.CombineLatest(appleStockObserver, googleStockObserver)
            .throttle(for: .seconds(3), scheduler: RunLoop.current, latest: true)
            .sink(receiveValue: { [weak self] (appleStock, googleStock) in
                self?.stockObserver.send((appleStock, googleStock))
            })
            .store(in: &cancellables)
    }
    
    func startUpdating() {
        
        while true {
            Thread.sleep(forTimeInterval: sleepDuration)
            
            appleStockObserver.send(newStockPrice)
            googleStockObserver.send(newStockPrice)
            
            Thread.sleep(forTimeInterval: sleepDuration)
            
            googleStockObserver.send(newStockPrice)
        }
    }
}
