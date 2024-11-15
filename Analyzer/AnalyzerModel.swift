//
//  AnalyzerModel.swift
//  BehaveAI
//
//  Created by Mostafa Mazrouh on 2024-11-15.
//

import Foundation

class AnalyzerModel: AnalyzerRepository {
    
    func getStrategy() -> String {
        return strategy
    }
    
    func getUserBehaviors() -> [(title: String, behavior: String)] {
        return userBehaviors
    }
    
    
    private let strategy = "In 100 words or less, please provide 3 suggestions for a brief investment strategy and balance portfolio risk based on the following Behavioral Analysis: "

    
    private let userBehaviors: [(title: String, behavior: String)] = [
        (
            title: "Tech Investor",
            behavior: """
            Focuses on companies in technology, especially those with strong growth potential in AI, software, or hardware. Looks for innovation and high R&D spending as signs of future success. Prioritizes growth over dividends, often investing in well-known tech giants.
            """
        ),
        (
            title: "Start-Up Investor",
            behavior: """
            Takes risks on early-stage companies that are breaking into new markets. Seeks out industries with disruptive potential, such as biotech or green tech. Tracks IPOs and new funding rounds to identify emerging opportunities.
            """
        ),
        (
            title: "Dividend Investor",
            behavior: """
            Invests in companies with reliable and consistent dividend payouts, often in stable sectors like utilities or telecom. Prefers firms with a track record of growing dividends over time. Looks for both income stability and moderate capital appreciation.
            """
        ),
        (
            title: "Sustainable Investor",
            behavior: """
            Focuses on companies with strong environmental, social, and governance (ESG) practices. Favors sectors like renewable energy and sustainable agriculture. Avoids industries deemed harmful, such as fossil fuels or tobacco.
            """
        ),
        (
            title: "Risky Investor",
            behavior: """
            Willing to take high risks for the chance of substantial returns, often in volatile markets like crypto or biotech. Makes aggressive trades based on market timing and sentiment. Keeps a close watch on economic news and trends for opportunities.
            """
        ),
        (
            title: "Value Investor",
            behavior: """
            Seeks undervalued companies with solid fundamentals and potential for growth. Looks for stocks trading below intrinsic value, often in out-of-favor sectors. Holds investments long-term, banking on market corrections to realize gains.
            """
        ),
        (
            title: "Growth Investor",
            behavior: """
            Prioritizes companies with high growth rates, often reinvesting earnings to fuel expansion. Focuses on industries with future growth potential like tech, healthcare, or green energy. Is willing to accept higher stock prices for strong growth prospects.
            """
        ),
        (
            title: "Real Estate Investor",
            behavior: """
            Invests in real estate stocks, REITs, or property-focused funds for income and asset appreciation. Looks for stable cash flows and diversification benefits. Often prefers high-demand locations and sectors like commercial or residential housing.
            """
        ),
        (
            title: "Defensive Investor",
            behavior: """
            Focuses on recession-resistant industries like healthcare, utilities, and consumer staples. Prefers stable, large-cap companies that can weather economic downturns. Values income stability and capital preservation over high returns.
            """
        ),
        (
            title: "International Investor",
            behavior: """
            Diversifies by investing in companies outside their home country, targeting emerging or high-growth markets. Seeks exposure to regions with strong economic growth potential, like Asia or Latin America. Aims to balance risk by investing across various currencies and economies.
            """
        )
    ]
}
