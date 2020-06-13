//
//  ContentView.swift
//  Memorize
//
//  Created by Eric Li on 2020/6/12.
//  Copyright © 2020 Eric Li. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("hello")
            Text("hello")
            Button(action: {
// do nothing
            }){
                Text("点击")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
        .cornerRadius(10)
        .shadow(radius: 10)
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
