//
//  ContentView.swift
//  Todo
//
//  Created by Konstantinos Nikoloutsos on 23/1/23.
//

import SwiftUI
import ComposableArchitecture

struct AppState: Equatable {
    var counter: Int
}

enum AppAction {
    case increaseCounter
    case decreaseCounter
}

struct AppEnvironment {
    
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .increaseCounter:
        if state.counter == 5 { // Business logic
            return .none
        }
        state.counter += 1
        return .none
        
    case .decreaseCounter:
        state.counter -= 1
        return .none
    }
}.debug()

struct ContentView: View {
    let store: Store<AppState, AppAction>
    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack(spacing: 20.0) {
                Button(action: { viewStore.send(.decreaseCounter) }) {
                    Text("-") 
                }
                Text("\(viewStore.counter)")
                Button(action: { viewStore.send(.increaseCounter) }) {
                    Text("+")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(
            initialState: .init(counter: 0),
            reducer: appReducer,
            environment: AppEnvironment()
        ))
    }
}
