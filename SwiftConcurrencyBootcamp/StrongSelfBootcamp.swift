//
//  StrongSelfBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/08/19.
//

import SwiftUI

final class StrongSelfDataService {
    
    func getData() async -> String {
        return "updated data!"
    }
}

final class StrongSelfBootcampViewModel: ObservableObject {
    
    @Published var data: String = "Some title!"
    let dataService = StrongSelfDataService()
    private var someTask: Task<Void, Never>? = nil
    
    /*
    // これは強参照を意味する
    func updateData() {
        Task {
            data = await dataService.getData()
        }
    }
    
    func updateData2() {
        Task {
            self.data = await dataService.getData()
        }
    }
    
    func updateData3() {
        Task { [self] in
            self.data = await dataService.getData()
        }
    }
    
    // 弱参照だとこのようになるが通常このようにしない
    func updateData4() {
        Task { [weak self] in
            if let data = await self?.dataService.getData() {
                self?.data = data
            }
        }
    }
    */
    
    // We don't need to manage weak/strong
    // we can manage the Task
    func updateData5() {
        someTask = Task {
            self.data = await self.dataService.getData()
        }
    }
    
    func cancelTasks() {
        someTask?.cancel()
        someTask = nil
    }
}

struct StrongSelfBootcamp: View {
    
    @StateObject private var viewModel = StrongSelfBootcampViewModel()
    
    var body: some View {
        Text(viewModel.data)
            .onAppear(perform: {
                viewModel.updateData5()
            })
            .onDisappear(perform: {
                viewModel.cancelTasks()
            })
    }
}

#Preview {
    StrongSelfBootcamp()
}
