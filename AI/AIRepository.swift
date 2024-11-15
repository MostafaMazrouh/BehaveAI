//
//  AIRepository.swift
//  BehaveAI
//
//  Created by Mostafa Mazrouh on 2024-11-15.
//

import Foundation

protocol AIRepository {
    func send(behaviorText: String) async throws -> String
}

class AIRepositoryMock: AIRepository {
    
    func send(behaviorText: String) async throws -> String {
        return "Help users develop a balanced, well-informed investment strategy based on their unique patterns and preferences"
        
    }
}
