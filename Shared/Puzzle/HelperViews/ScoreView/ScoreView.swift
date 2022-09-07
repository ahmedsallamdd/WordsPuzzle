//
//  ScoreView.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 05/09/2022.
//

import SwiftUI

struct ScoreView: View {
    @State var currentTimerValue = "00:00:00"
    
    fileprivate let startDate = Date()
    fileprivate let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Button(action: {
                
            }, label: {
                HStack {
                    Image(systemName: "forward.end.fill")
                        .foregroundColor(.white)
                    
                    Text("Skip")
                }
            })
            .padding(.all)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
            
            Spacer()
            
            VStack {
                Text("\(currentTimerValue)")
                    .onReceive(timer, perform: { value in
                        let time = Int(Date().timeIntervalSince(startDate))
                        let hours = time / (60 * 60)
                        let minutes = time / 60
                        let seconds = time % 60
                        
                        currentTimerValue = String(format: "%02d:%02d:%02d",
                                                   hours,
                                                   minutes,
                                                   seconds)
                    })
                    .foregroundColor(.white)
                    .font(Font.system(.title2))
                
            }
        }
        .padding(.all)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
