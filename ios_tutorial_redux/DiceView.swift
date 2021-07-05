//
//  dice_preview.swift
//  ios_tutorial_redux
//
//  Created by 최승원 on 2021/07/04.
//

import Foundation
import SwiftUI

struct DiceView: View {
    
    // 외부에서 등록한 environmentObject() 덕분에 store를 넘겨 받을 수 있음
    @EnvironmentObject var store : AppStore
    
    
    /// Animation 처리
    @State private var shouldRoll = false
    
    @State private var pressed = false
    
    var diceRollAnimation: Animation {
        Animation.spring()
    }
    
    ///
    
    
    
    // 주사위 굴리기 액션을 실행한다.
    func rollTheDice(){
        // 디버깅 방법
        print(#fileID, #function, #line)
        self.shouldRoll.toggle()
        self.store.dispatch(action: .rollTheDice)
    }
    
    var body: some View {
        
        VStack{
            // 바뀐 상태값 활용하여 등록
            Text(self.store.state.currentDice)
                .font(.system(size: 300, weight: .bold, design: .monospaced))
                .foregroundColor(Color.init(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                //anition 등록
                .rotationEffect(.degrees(shouldRoll ? 360 : 0))
                .animation(diceRollAnimation)
            Button(
                action: {
                    
                    // 실질적인 Acton 등록
                    self.rollTheDice()
                    
                    
                },
                label: {
                    Text("주사위 굴리깅!!")
                        .fontWeight(.black)
                })
                .buttonStyle(MyButtonStyle())
                .scaleEffect(self.pressed ? 0.8 : 1)
                .onLongPressGesture(
                    minimumDuration: .infinity,
                    maximumDistance: .infinity,
                    pressing: { pressing in
                        withAnimation(.easeOut(duration: 0.2),{
                            self.pressed = pressing
                        })
                    },
                    perform: {}
                )
            }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View{
        DiceView()
    }
}
