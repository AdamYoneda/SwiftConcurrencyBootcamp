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
    
    func updateData() {
        Task {
            data = await dataService.getData()
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
