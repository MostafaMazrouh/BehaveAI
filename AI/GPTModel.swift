//
//  GPTModel.swift
//  BehaveAI
//
//  Created by Mostafa Mazrouh on 2024-11-10.
//

import Foundation
import OpenAI

let apiKey = ""


class GPTModel: AIRepository {
    let openAI = OpenAI(apiToken: apiKey)
    
    func send(behaviorText: String) async throws -> String {
        guard let message = ChatQuery.ChatCompletionMessageParam.init(role: .user, content: behaviorText) else { throw BehaveError.invalidMessage }
        
        let query = ChatQuery(messages: [message], model: .gpt4_o_mini)
        let result = try await openAI.chats(query: query)
        
        guard let reply = result.choices.first?.message.content?.string else { throw BehaveError.invalidResponse }
        
        return reply
    }
}

enum BehaveError: Error {
    case invalidMessage
    case invalidResponse
}
