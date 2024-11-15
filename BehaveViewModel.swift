//
//  BehaveViewModel.swift
//  BehaveAI
//
//  Created by Mostafa Mazrouh on 2024-11-11.
//

import Foundation

@MainActor
class BehaveViewModel: ObservableObject {
    
    @Published var reply: String = ""
    
    let aiModel: AIRepository
    let analyzerModel: AnalyzerRepository
    
    // init(aiModel: AIRepository = GPTModel())
    init(aiModel: AIRepository, analyzerModel: AnalyzerRepository) {
        self.aiModel = aiModel
        self.analyzerModel = analyzerModel
    }
    
    func sendUserBehaviour(userBehavior: String) {
        Task {
            do {
                
                let behaviorText = analyzerModel.getStrategy() + userBehavior
                reply = try await aiModel.send(behaviorText: behaviorText)
                print("reply: \(reply)")
            } catch {
                reply = "Error: \(error)"
                print("Error: \(error)")
            }
        }
        
    }
}
