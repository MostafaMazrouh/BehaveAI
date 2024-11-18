//
//  LiveUpdatesView.swift
//  BehaveAI
//
//  Created by Mostafa Mazrouh on 2024-11-17.
//

import SwiftUI

struct LiveUpdatesView: View {
    
    @ObservedObject var liveUpdatesVM = LiveUpdatesVM()
    
    var body: some View {
        VStack(alignment: .center) {
            SmallView(title: "Combine",
                      stock: liveUpdatesVM.combineInsight,
                      currentVlaue: liveUpdatesVM.combineCurrent
            )
            .onTapGesture {
                liveUpdatesVM.updateCombineCurrent()
            }
            
            SmallView(title: "Swift concurrency",
                      stock: liveUpdatesVM.concurrencyInsight,
                      currentVlaue: liveUpdatesVM.concurrencyCurrent
            )
            .onTapGesture {
                liveUpdatesVM.updateConcurrencyCurrent()
            }
        }
    }
}

struct SmallView: View {
    
    var title: String
    var stock: String
    var currentVlaue: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            
            ParsedText(stock)
                .contentTransition(.numericText())
                .padding()
            
            Text("Current value: \(currentVlaue)")
        }
        .foregroundColor(.white)
        .animation(.smooth, value: stock)
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}


#Preview {
    LiveUpdatesView()
}
