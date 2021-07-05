//
//  ContentView.swift
//  ios_tutorial_redux
//
//  Created by 최승원 on 2021/07/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        // store 생성
        let store = AppStore(
            state: AppState.init(currentDice: "⚀"),
            reducer: appReducer(_:_:)
        )
        // View에 observerObject를 넣기 위해서는 environmentObject를 넣어주면 된다.
        // 하위 view에 변경 가능한 녀석(AppStore)을 넣어준다.
        // 서브부에 옵저버블 오브젝트를 연결한다.
        DiceView().environmentObject(store)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
