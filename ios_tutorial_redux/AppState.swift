//
//  AppState.swift
//  ios_tutorial_redux
//
//  Created by 최승원 on 2021/07/04.
//

import Foundation

//앱의 상태 관리 - 데이터
struct AppState {
    var currentDice: String =  "" {
        didSet{
            print("currentDice : \(currentDice)", #function, #fileID)
        }
    }
    
}
