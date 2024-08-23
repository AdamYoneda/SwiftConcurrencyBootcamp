//
//  SearchableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/08/23.
//

import SwiftUI

struct Restaurant: Identifiable, Hashable {
    let id: String
    let title: String
    let cuisine: CuisineOption
}

enum CuisineOption {
    case american, italian, japanese
}

final class RestaurantManager {
    
    func getAllRestaurant() async throws -> [Restaurant] {
        [
            Restaurant(id: "1", title: "Burger Shack", cuisine: .american),
            Restaurant(id: "2", title: "Pasta Palace", cuisine: .italian),
            Restaurant(id: "3", title: "Sushi Heaven", cuisine: .japanese),
            Restaurant(id: "4", title: "Local Market", cuisine: .american)
        ]
    }
}

@MainActor
final class SearchableBootcampViewModel: ObservableObject {
    @Published private(set) var allRestaurants: [Restaurant] = []
    let manager = RestaurantManager()
    
    func loadRestaurants() async {
        do {
            allRestaurants = try await manager.getAllRestaurant()
        } catch {
            print(error)
        }
    }
}

struct SearchableBootcamp: View {
    
    @StateObject private var viewModel = SearchableBootcampViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                await viewModel.loadRestaurants()
            }
    }
}

#Preview {
    SearchableBootcamp()
}
