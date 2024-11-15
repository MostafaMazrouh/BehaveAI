//
//  BehaveAIApp.swift
//  BehaveAI
//
//  Created by Mostafa Mazrouh on 2024-11-09.
//

import SwiftUI

@main
struct BehaveAIApp: App {
    
    let behaveViewModel: BehaveViewModel
    let aiModel: AIRepository
    let analyzerModel: AnalyzerRepository
    
    
    init() {
        aiModel = GPTModel()
        analyzerModel = AnalyzerModel()
        behaveViewModel = BehaveViewModel(aiModel: aiModel, analyzerModel: analyzerModel)
    }
    
    var body: some Scene {
        WindowGroup {
            BehaveView(behaveViewModel: behaveViewModel)
        }
    }
}
