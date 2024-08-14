//
//  AsyncPublisherBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/08/14.
//

import SwiftUI

actor AsyncPublisherDataManager {
    
    @Published var myData: [String] = []
    
}

class AsyncPublisherBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
}

struct AsyncPublisherBootcamp: View {
    
    @StateObject private var viewModel = AsyncPublisherBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack(content: {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            })
        }
        .task {
            await viewModel.start()
        }
    }
}

#Preview {
    AsyncPublisherBootcamp()
}
