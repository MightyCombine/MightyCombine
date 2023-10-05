//
//  ContentView.swift
//  Example
//
//  Created by 김인섭 on 10/5/23.
//

import SwiftUI

struct ContentView: View {
    
    let viewModel = ViewModel()
    
    var body: some View {
    
        Button(action: { viewModel.didTapButton() }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
    }
}

#Preview {
    ContentView()
}
