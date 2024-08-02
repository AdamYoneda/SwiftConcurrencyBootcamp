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

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.8).ignoresSafeArea()
        }
    }
}

struct BrowseView: View {
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
        }
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
