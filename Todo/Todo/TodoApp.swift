//
//  TodoApp.swift
//  Todo
//
//  Created by Konstantinos Nikoloutsos on 23/1/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct TodoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(
                initialState: .init(counters: [0, 0]),
                reducer: appReducer,
                environment: AppEnvironment()
            ))
        }
    }
}
