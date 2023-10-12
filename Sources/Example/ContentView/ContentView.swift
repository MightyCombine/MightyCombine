//
//  ContentView.swift
//  Example
//
//  Created by 김인섭 on 10/11/23.
//
#if canImport(SwiftUI)
import SwiftUI

struct ContentView: View {
    
    let viewModel = ViewModel()
    
    var body: some View {
        Button("Get Octocat") {
            viewModel.didTapButton()
        }
    }
}

#endif
