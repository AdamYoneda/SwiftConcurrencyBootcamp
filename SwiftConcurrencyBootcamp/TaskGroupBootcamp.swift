//
//  TaskGroupBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/07/09.
//

import SwiftUI

class TaskGroupBootcampViewModel: ObservableObject {
    @Published var images: [UIImage] = []
}

struct TaskGroupBootcamp: View {
    
    @StateObject private var viewModel = TaskGroupBootcampViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView(content: {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                })
            }
            .navigationTitle("Task Group 🙄")
        })
    }
}

#Preview {
    TaskGroupBootcamp()
}
