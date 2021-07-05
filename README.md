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

## Redux의 등록 흐름




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
```ㅅㅣ
```
