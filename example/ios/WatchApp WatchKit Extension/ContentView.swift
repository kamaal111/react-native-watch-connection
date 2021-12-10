//
//  ContentView.swift
//  WatchApp WatchKit Extension
//
//  Created by Kamaal Farah on 10/12/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject
    private var chronos: Chronos

    var body: some View {
        VStack {
            Button(action: {
                chronos.sendWatchMessage()
            }) {
                Text("Send message")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
