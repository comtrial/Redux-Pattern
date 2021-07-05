# ios_tutorial_redux 

## Redux 개념

앱 내의 데이터들의 상태 관리를 위한 패턴이다. 



**데이터의 상태관리란**
:앱 상의 페이지 간의 데이터 이동, api 통신을 통한 데이터 전달, 페이지 내 Event에 의한 창내 데이터 변환 등의 어플리케이션 내부에서 일어나는
변화들을 의미 한다. 


![image](https://user-images.githubusercontent.com/67617819/124408965-58c93380-dd82-11eb-8ce9-8b17c80c5d25.png)


---
### 상태관리의 중요성

어플리케이션, 웹 등의 크고 작은 프로젝트를 진행해 보면서 처음에는 그저 페이지를 그린다라는 생각이였는데, 조금이라도 데이터의 통신이 생기는 경우 페이지를 먼저 생각하는 것이 아닌, 데이터에 의한 페이지의 그려짐이라는 생각이 들었다.

그렇기에 상태관리에 대한 구상이 선행된 후 페이지 구조를 잡는 것이 더 유지보수가 용이한 코드가 된다 생각하여, 상태 관리의 개념 tutoriald을 진행했습니당.

---

구현이 되는 흐름과 구현을 위한 코드의 작성 흐름은 다르다고 생각하여 두가지의 흐름으로 정리


## Redux의 동작 흐름

1. 페이지 내의 Event, 즉 Action의 발생 ( btn click )
  : store의 dispatch를 통한 action의 전달
```
 func rollTheDice(){
        print(#fileID, #function, #line)
        self.shouldRoll.toggle()
        // dispatch를 통해 action을 넣어줌
        self.store.dispatch(action: .rollTheDice)
    }
    
 ...
 
 Button(
                action: {            
                    // 실질적인 Acton 등록
                    self.rollTheDice()  
                },
```
2. store를 통해 들어온 Reducer의 실행
  : 들어오는 action에 따른 분기처리를 진행해 주기 위한 Reducer 실행

```
// closer 개념 // inout: (주로 State) 매개 변수로 들어오능 값을 변경할 때 쓰는 키워드
typealias Reducer<State, Action> = (inout State, Action) -> Void
// (inout State, Action) -> void 해당 클로저 자체를 Reducer로 칭함 State와 Action을 기지고 있음


//필터링을 해주는 메서드
func appReducer(_ state: inout AppState, _ action: AppAction) -> Void {
    
    //들어오는 액션에 따른 분기처리 진행 - 필터링
    switch action {
    case .rollTheDice:
        print(#fileID, #function, #line, "AppReducer 실행됨")
        // 앱의 상태 값 변경
        state.currentDice = [
        "⚀","⚁","⚂","⚃","⚄","⚅"
        ].randomElement() ?? "⚀"  //?? 값이 비었을 경우
   
    }
}

```


3. 위의 Reducer의 실행을 통해 변경된 Store의 상태 값 변경을 통한 View의 갱신 진행


---
## Redux의 등록 흐름

1. Store 생성: State와 Action 정의 

```
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
```

2. Reducer 등록: 앱의 상태 값 변경
  : 구현 하고자 하는 액션에 대한 정의 및 분기 처리 진행

```
typealias Reducer<State, Action> = (inout State, Action) -> Void
// (inout State, Action) -> void 해당 클로저 자체를 Reducer로 칭함 State와 Action을 기지고 있음

//필터링을 해주는 메서드
func appReducer(_ state: inout AppState, _ action: AppAction) -> Void {
    //들어오는 액션에 따른 분기처리 진행 - 필터링
    switch action {
    case .rollTheDice:
        print(#fileID, #function, #line, "AppReducer 실행됨")
        // 앱의 상태 값 변경
        state.currentDice = [
        "⚀","⚁","⚂","⚃","⚄","⚅"
        ].randomElement() ?? "⚀" 
    }
}
```
 

3. main에서 상태관리를 해주고 싶은 View에 store 등록을 한다. 
  `DiceView().environmentObject(store)`

```
struct ContentView: View {
    var body: some View {
        // store 생성
        let store = AppStore(
            state: AppState.init(currentDice: "⚀"),
            reducer: appReducer(_:_:)
        )
        // <Binding> -> UI 와 Store를 bkinding 시켜줌
        // View에 observerObject를 넣기 위해서는 environmentObject를 넣어주면 된다.
        // 하위 view에 변경 가능한 녀석(AppStore)을 넣어준다.
        // 서브부에 옵저버블 오브젝트를 연결한다.
        DiceView().environmentObject(store)
    }
}
```

4. 직접적으로 상태를 관리하고 싶은 View()에 store 전달 받음

```
    // 외부에서 등록한 environmentObject() 덕분에 store를 넘겨 받을 수 있음
    @EnvironmentObject var store : AppStore
```

5. View()에 action func 등록
  : 넘겨받은 store를 사용하여 dispatch를 통해 action에 접근하여 상태 값 변경
```
    // 주사위 굴리기 액션을 실행한다.
    func rollTheDice(){
        // 디버깅 방법
        print(#fileID, #function, #line)
        self.shouldRoll.toggle()
        // dispatch를 통해 action을 넣어줌
        self.store.dispatch(action: .rollTheDice)
    }
```

6. Store를 등록하였기 때문에 state의 변경이 일어날 경우 자동으로 화면 갱신


![ezgif com-gif-maker](https://user-images.githubusercontent.com/67617819/124414203-2ffa6b80-dd8d-11eb-8115-e7750717b638.gif)

