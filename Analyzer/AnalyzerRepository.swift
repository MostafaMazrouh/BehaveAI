//
//  AnalyzerRepository.swift
//  BehaveAI
//
//  Created by Mostafa Mazrouh on 2024-11-15.
//

import Foundation

protocol AnalyzerRepository {
    func getStrategy() -> String
    func getUserBehaviors() -> [(title: String, behavior: String)]
}


class AnalyzerRepositoryMock: AnalyzerRepository {
    
    func getStrategy() -> String {
        return "Investment strategy"
    }
    
    func getUserBehaviors() -> [(title: String, behavior: String)] {
        return [("Tech investor", "Investing in tech companies")]
    }
}
