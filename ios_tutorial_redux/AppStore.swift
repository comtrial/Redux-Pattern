//
//  AppStore.swift
//  ios_tutorial_redux
//
//  Created by 최승원 on 2021/07/04.
//

import Foundation

//앱의 모든 상태를 가지고 있는 파일

// 앱 스토어는 앱 상태와 앱 액션을 가지고 있다
// 앱의 상태를 지니고 있기 위해 앱 스토어를 만들어 준다.
// 읽기 위주의 로직이 사용된다.

typealias AppStore = Store<AppState, AppAction>

// ObservableObject 앱 상태를 가지고 있는 변수
// 상태가 변함을 감지하고 Binding 을 해줌
final class Store<State, Action>: ObservableObject {
    
    // 상태의 변경이 일어날 경우 받아주는 published
    @Published private(set) var state: State
    
    // 외부에서 읽을 수만 있도록 private(set)
    private let reducer: Reducer<State, Action>
    
    
    //생성자: State와 Reducer를 넣어줘서 Store를 만들어준다.
    // Reducer는 closer이기 때문에 escape 달아줌
    init(state: State, reducer: @escaping Reducer<State, Action>) {
        self.state = state
        self.reducer = reducer
    }
    
    //디스패치를 통해 액션을 행한다.
    func dispatch(action: Action) {
        // inout 매개변수를 넣을 때는 & 를 사용한다.
        // 리듀서 클로저를 실행해서 액션을 필터링 한다.
        reducer(&self.state, action)
    }
}
