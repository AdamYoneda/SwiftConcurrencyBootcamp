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
}

struct StrongSelfBootcamp: View {
    
    @StateObject private var viewModel = StrongSelfBootcampViewModel()
    
    var body: some View {
        Text(viewModel.data)
            .onAppear(perform: {
                viewModel.updateData()
            })
    }
}

#Preview {
    StrongSelfBootcamp()
}
