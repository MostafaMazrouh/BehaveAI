//
//  BehaveView.swift
//  BehaveAI
//
//  Created by Mostafa Mazrouh on 2024-11-11.
//

import SwiftUI


struct BehaveView: View {
    @ObservedObject var behaveViewModel: BehaveViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        ForEach(behaveViewModel.analyzerModel.getUserBehaviors(), id: \.0) { behavior, description in
                            
                            NavigationLink(destination:
                                            
                                            StrategyView(title: behavior, description: description)
                                .environmentObject(behaveViewModel)
                            ) {
                                
                                BehaviorItem(behavior: behavior, description: description)
                                
                            }
                        }
                    }
                }
                .navigationBarTitle("Investor Behaviors")
                .navigationBarTitleDisplayMode(.large)
                .scrollContentBackground(.visible)
                
                Spacer()
                
                NavigationLink(destination:LiveUpdatesView()) {
                    Text("Analyze")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding()
                }
            }
            .background(Color.clear)
        }
    }
}

struct BehaviorItem: View {
    let behavior: String, description: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(behavior)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                
                Text(description)
                    .lineLimit(2)
                    .font(.system(size: 14, weight: .light, design: .rounded))
                    .padding(.top, 0)
            }
            Spacer()
        }
    }
}

struct StrategyView: View {
    @EnvironmentObject var behaveViewModel: BehaveViewModel
    @State var isLoading: Bool = false
    
    let title: String, description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .padding(.bottom, 10)
            
            Text(description)
                .font(.system(size: 14, weight: .light, design: .rounded))
                .padding(.bottom, 10)
            
            Button(action: {
                isLoading = true
                behaveViewModel.sendUserBehaviour(userBehavior: description)
            }) {
                HStack {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                    Text(isLoading ? "Loading..." :
                            "Generate Strategy using ChatGPT")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            }

            
            ScrollView {
                ParsedText(behaveViewModel.reply)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Investment Strategy")
        .onChange(of: behaveViewModel.reply) { oldValue, newValue in
            isLoading = false
        }
        .onDisappear {
            behaveViewModel.reply = ""
        }
    }
}

extension View {
    func ParsedText(_ text: String) -> Text {
        // Split the text by `**`
        let parts = text.components(separatedBy: "**")
        var result: Text = Text("")
        
        // Iterate through parts and apply bold or regular styles
        for (index, part) in parts.enumerated() {
            if index % 2 == 0 {
                // Regular text
                result = result + Text(part).fontWeight(.light)
            } else {
                // Bold text
                result = result + Text(part).fontWeight(.bold)
            }
        }
        
        return result
    }
}


#Preview {
    BehaveView(behaveViewModel: BehaveViewModel(aiModel: GPTModel(), analyzerModel: AnalyzerModel()))
}
