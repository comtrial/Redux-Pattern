//
//  Reducer.swift
//  ios_tutorial_redux
//
//  Created by 최승원 on 2021/07/04.
//

import Foundation

//typealias 별칭으로 만든다라는 개념

// closer 개념 // inout: (주로 State) 매개 변수로 들어오능 값을 변경할 때 쓰는 키워드
typealias Reducer<State, Action> = (inout State, Action) -> Void
// (inout State, Action) -> void 해당 클로저 자체를 Reducer로 칭함 State와 Action을 기지고 있음
// Reducer == 클로저


//필터링을 해주는 메서드
func appReducer(_ state: inout AppState, _ action: AppAction) -> Void {
    
    //들어오는 액션에 따른 분기처리 진행 - 필터링
    switch action {
    case .rollTheDice:
        // 앱의 상태 값 변경
        state.currentDice = [
        "⚀","⚁","⚂","⚃","⚄","⚅"
        ].randomElement() ?? "⚀"  //?? 값이 비었을 경우
   
    }
}
