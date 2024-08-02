//
//  ActorsBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/08/02.
//

import SwiftUI

// 1. What is the problem that actor are solving?
// 2. How was this problem solved prior to actors?
// 3. Actors can solve the problem!

class MyDataManager {
    // Singleton
    static let instance = MyDataManager()
    private init() { }
    
    var data: [String] = []
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return data.randomElement()
    }
}

struct HomeView: View {
    
    let manager = MyDataManager.instance
    @State private var text: String = ""
    // Viewが作られると自動的にスタートする
    let timer = Timer.publish(every: 0.1, tolerance: nil, on: .main, in: .common, options: nil).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer, perform: { _ in
            if let data = manager.getRandomData() {
                self.text = data
            }
        })
    }
}

struct BrowseView: View {
    
    let manager = MyDataManager.instance
    @State private var text: String = ""
    // Viewが作られると自動的にスタートする
    let timer = Timer.publish(every: 0.3, tolerance: nil, on: .main, in: .common, options: nil).autoconnect()
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer, perform: { _ in
            if let data = manager.getRandomData() {
                self.text = data
            }
        })
    }
}

struct ActorsBootcamp: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ActorsBootcamp()
}
