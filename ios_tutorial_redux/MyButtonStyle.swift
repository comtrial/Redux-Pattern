//
//  MyButtonStyle.swift
//  Redux_test
//
//  Created by Jeff Jeong on 2021/02/16.
//

import Foundation
import SwiftUI
struct MyButtonStyle: ButtonStyle {
    
    //
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 20))
           .padding()
            .background(Color.init(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
           .foregroundColor(Color.white)
           .cornerRadius(20)
    }
}

struct MyButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
            
        }, label: {
            Text("하하하")
                .fontWeight(.heavy)
        }).buttonStyle(MyButtonStyle())
    }
}
