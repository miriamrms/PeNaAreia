//
//  LaunchScreenView.swift
//  PeNaAreia
//
//  Created by Marina Meirelles Paixão on 12/09/24.
//

import SwiftUI

struct AnimatedWaveView: View {
    @State private var phase: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            TimelineView(.animation) { timeline in
                let date = timeline.date.timeIntervalSinceReferenceDate
                let animatedPhase = CGFloat(date.truncatingRemainder(dividingBy: 2)) * .pi * 2
                
                ZStack {
                    WaveShape(waveHeight: 30, phase: animatedPhase)
                        .fill(Color.lightblue)
                        .frame(height: 820)
                        .offset(y: 10)
                    
                    Wave2Shape(waveHeight: 30, phase: animatedPhase)
                        .fill(Color.darkblue)
                        .frame(height: 430)
                        .offset(y: 200)
                }
                
                
            }
            
            VStack {
                Spacer()
                    .frame(height: 200)
                
                
                Image("Frame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300.0, height: 80.0)
                Spacer()
            }
        }
    }
}

struct WaveShape: Shape {
    var waveHeight: CGFloat
    var phase: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: 0, y: height))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / width
            let sine = sin(2.3 * .pi * relativeX + phase)
            let y = waveHeight * sine + height * 0.5
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

struct Wave2Shape: Shape {
    var waveHeight: CGFloat
    var phase: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: 0, y: height))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / width
            let sine = sin(1 * .pi * relativeX + phase)
            let y = waveHeight * sine + height * 0.08
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

struct Wave2ShapeReverse: Shape {
    var waveHeight: CGFloat
    var phase: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: 0, y: height))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / width
            let sine = sin(1 * .pi * relativeX - phase)
            let y = waveHeight * sine + height * 0.08
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

import SwiftUI

struct WaveShapeOpposite: Shape {
    var waveHeight: CGFloat
    var phase: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: 0, y: height))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / width
            let sine = sin(2.3 * .pi * relativeX - phase)
            let y = waveHeight * sine + height * 0.5
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}


#Preview {
    AnimatedWaveView()
}

