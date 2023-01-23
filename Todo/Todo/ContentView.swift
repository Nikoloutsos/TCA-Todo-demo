//
//  ContentView.swift
//  Todo
//
//  Created by Konstantinos Nikoloutsos on 23/1/23.
//

import SwiftUI
import ComposableArchitecture

struct AppState: Equatable {
    var counters: [Int]
}

enum AppAction {
    case increaseCounter(index: Int)
    case decreaseCounter(index: Int)
}

struct AppEnvironment {
    
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .increaseCounter(let index):
        state.counters[index] += 1
        return .none
        
    case .decreaseCounter(let index):
        state.counters[index] -= 1
        return .none
    }
}.debug()

struct ContentView: View {
    let store: Store<AppState, AppAction>
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                CounterCell(viewStore: viewStore, index: 0)
                CounterCell(viewStore: viewStore, index: 1)
            }
            
        }
    }
}

struct CounterCell: View {
    let viewStore: ViewStore<AppState, AppAction>
    let index: Int
    
    var body: some View {
            HStack(spacing: 20.0) {
                Button(action: { viewStore.send(.decreaseCounter(index: index)) }) {
                    Text("-")
                }
                Text("\(viewStore.counters[index])")
                Button(action: { viewStore.send(.increaseCounter(index: index)) }) {
                    Text("+")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(
            initialState: .init(counters: [0, 0]),
            reducer: appReducer,
            environment: AppEnvironment()
        ))
    }
}
