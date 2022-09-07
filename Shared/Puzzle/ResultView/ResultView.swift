//
//  ResultView.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 07/09/2022.
//

import SwiftUI

public enum QuizResult {
    case win
    case lose
    
    func getTitle() -> String {
        switch self {
        case .win: return "Congratulations!"
        case .lose: return "Game Over!"
        }
    }
    
    func getColor() -> Color {
        switch self {
        case .win: return .winningColor
        case .lose: return .losingColor
        }
    }
}

struct ResultViewComponents {
    let title: String
    let color: Color
}

struct ResultView: View {
    let result: QuizResult
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center) {
                Spacer()
                
                Text(result.getTitle().uppercased())
                    .bold()
                    .foregroundColor(result.getColor())
                    .font(.title)
                
                Spacer()
                
                VStack {
                    Text("The correct answer is")
                        .bold()
                        .foregroundColor(result.getColor())
                        .font(.headline)
                        .frame(alignment: .center)

                    Text("\(GameSession.shared.currentQuiz.content.uppercased())")
                        .bold()
                        .foregroundColor(result.getColor())
                        .font(.title)
                        .frame(alignment: .center)
                }
                .padding()
                .border(result.getColor(), width: 4.5)
                .cornerRadius(8)
                
                Spacer()

                Button(action: {
                    AppState.shared.currentView = .game
                }, label: {
                    Text("Play Again")
                        .frame(minWidth: .zero, maxWidth: .infinity)
                        

                })
                .padding(.all)
                .foregroundColor(.white)
                .background(result.getColor())
                .cornerRadius(10)
                .padding()
            }
            
            
            if result == .win {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                    .offset(x: -100, y : -50)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                    .offset(x: 60, y : 70)
                
            }
            
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(result: .win)
    }
}

struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 20 ... 200)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}

struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 4.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.linear(duration: duration).repeatForever(autoreverses: false)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
}
