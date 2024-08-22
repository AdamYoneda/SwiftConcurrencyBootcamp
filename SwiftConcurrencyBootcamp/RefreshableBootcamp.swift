//
//  RefreshableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/08/22.
//

import SwiftUI

final class RefreshableDataService {
    
    func getData() async throws -> [String] {
        return ["Apple", "Orange", "Banana"].shuffled()
    }
}

@MainActor
final class RefreshableBootcampViewModel: ObservableObject {
    @Published private(set) var items: [String] = []
    let manager = RefreshableDataService()
    
    func loadData() {
        Task {
            do {
                items = try await manager.getData()
            } catch {
                print(error)
            }
        }
    }
}

struct RefreshableBootcamp: View {
    
    @StateObject private var viewModel = RefreshableBootcampViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(content: {
                    ForEach(viewModel.items, id: \.self) { item in
                        Text(item)
                            .font(.headline)
                    }
                })
            }
            .navigationTitle("Refreshable")
            .onAppear(perform: {
                viewModel.loadData()
            })
        }
    }
}

#Preview {
    RefreshableBootcamp()
}
