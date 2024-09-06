//
//  CapacityAlertView.swift
//  PeNaAreia
//
//  Created by Vitória Beltrão Wenceslau do Ó on 30/08/24.
//

import SwiftUI

struct CapacityAlertView: View {
    
    var tent: String
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 24, height: 24)))
                .frame(width: 360, height: 100)
                .foregroundStyle(Color.backgroundsand)
                .shadow(radius: 12)
            
            VStack (spacing: 18) {
                
                Text("A lotação da \(tent) está:")
                    .foregroundStyle(Color.mediumblue)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                
                
                
                HStack {
                    
                    AlertButtons(capacity: "Baixa")
                    
                    Spacer()
                    
                    AlertButtons(capacity: "Média")
                    
                    Spacer()
                    
                    AlertButtons(capacity: "Alta")
                    
                } .frame(width: 300)
                
            }
            
            
        }
        
    }
}

struct AlertButtons: View {
    
    var capacity: String
    
    var body: some View {
        
        Button(action: {}, label: {
            
            ZStack {
            Rectangle()
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                .frame(width: 80, height: 30)
                .foregroundStyle(Color.mediumblue)
                Text("\(capacity)")
                    .foregroundStyle(Color.backgroundsand)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
            }
        })
        
    }
}

#Preview {
    CapacityAlertView(tent: "Barraca do Tio")
}
