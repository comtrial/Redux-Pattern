//
//  dice_preview.swift
//  ios_tutorial_redux
//
//  Created by 최승원 on 2021/07/04.
//

import Foundation
import SwiftUI

struct DiceView: View {
    var body: some View {
        
        VStack{
            Text("⚀")
                .font(.system(size: 300, weight: .bold, design: .monospaced))
                .foregroundColor(Color.init(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
            
            Button(
                action: {
                    
                },
                label: {
                    Text("주사위 굴리깅!!")
                })
        }
        
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View{
        DiceView()
    }
}
