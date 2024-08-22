//
//  RefreshableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/08/22.
//

import SwiftUI

final class RefreshableDataService {
    
    func getData() async throws -> [String] {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        return ["Apple", "Orange", "Banana"].shuffled()
    }
}

@MainActor
final class RefreshableBootcampViewModel: ObservableObject {
    @Published private(set) var items: [String] = []
    let manager = RefreshableDataService()
    
    func loadData() async {
        do {
            items = try await manager.getData()
        } catch {
            print(error)
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
            .refreshable {
                await viewModel.loadData()
            }
            .navigationTitle("Refreshable")
            .onAppear(perform: {
                Task {
                    await viewModel.loadData()
                }
            })
        }
    }
}

#Preview {
    RefreshableBootcamp()
}
